#Alamofire-SwiftyJSON

Easy way to use both [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## Requirements

- iOS 7.0+ / Mac OS X 10.9+
- Xcode 7

## Usage

```swift
Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
         .responseSwiftyJSON({ (request, response, result) in
                     println(result)
                  })

```
