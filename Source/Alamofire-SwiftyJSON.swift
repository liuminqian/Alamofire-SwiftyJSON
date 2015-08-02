//
//  AlamofireSwiftyJSON.swift
//  AlamofireSwiftyJSON
//
//  Created by Pinglin Tang on 14-9-22.
//  Copyright (c) 2014 SwiftyJSON. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

// MARK: - Request for Swift JSON

extension Request {
    
    /**
    Adds a handler to be called once the request has finished.
    
    :param: completionHandler A closure to be executed once the request has finished. The closure takes 3 arguments: the URL request, the URL response, the JSON Result.
    
    :returns: The request.
    */
    public func responseSwiftyJSON(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<SwiftyJSON.JSON>) -> Void) -> Self {
        return responseSwiftyJSON(options:NSJSONReadingOptions.AllowFragments, completionHandler:completionHandler)
    }
    
    /**
    Adds a handler to be called once the request has finished.
    
    :param: queue The queue on which the completion handler is dispatched.
    :param: options The JSON serialization reading options. `.AllowFragments` by default.
    :param: completionHandler A closure to be executed once the request has finished. The closure takes 3 arguments: the URL request, the URL response, the JSON Result.
    
    :returns: The request.
    */
    
    public func responseSwiftyJSON(queue: dispatch_queue_t? = nil, options: NSJSONReadingOptions = .AllowFragments, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<SwiftyJSON.JSON>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: Request.JSONResponseSerializer(options: options), completionHandler: { (request, response, result) -> Void in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                
                var jsonResult: Result<SwiftyJSON.JSON>
                
                switch (result) {
                case .Success(let object):
                    jsonResult = .Success(SwiftyJSON.JSON(object))
                case .Failure(let object , let error):
                    jsonResult = .Failure(object, error)
                }
                
                dispatch_async(queue ?? dispatch_get_main_queue(), {
                    completionHandler(request, response, jsonResult)
                })
            })
        })
    }
}


