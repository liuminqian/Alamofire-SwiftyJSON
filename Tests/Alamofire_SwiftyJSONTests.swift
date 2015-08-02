//
//  Alamofire_SwiftyJSONTests.swift
//  Alamofire-SwiftyJSONTests
//
//  Created by Pinglin Tang on 14-9-23.
//  Copyright (c) 2014年 SwiftJSON. All rights reserved.
//

import UIKit
import XCTest
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class Alamofire_SwiftyJSONTests: XCTestCase {
    
    func testJSONResponse() {
        let URL = "http://httpbin.org/get"
        let expectation = expectationWithDescription("\(URL)")
        
        Alamofire.request(.GET, URL, parameters: ["foo": "bar"])
                 .responseSwiftyJSON ({ (request, response, result) in
                    expectation.fulfill()
                    XCTAssertNotNil(request, "request should not be nil")
                    XCTAssertNotNil(response, "response should not be nil")
                    switch (result) {
                    case .Success(let jsonResult):
                        XCTAssertEqual(jsonResult["args"], SwiftyJSON.JSON(["foo": "bar"] as NSDictionary), "args should be equal")
                    case .Failure(_, let error):
                        XCTAssertNil(error, "error should be nil")
                    }
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
}
