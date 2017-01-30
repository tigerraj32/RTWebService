# RTWebService

[![CI Status](http://img.shields.io/travis/rajan/RTWebService.svg?style=flat)](https://travis-ci.org/rajan/RTWebService)
[![Version](https://img.shields.io/cocoapods/v/RTWebService.svg?style=flat)](http://cocoapods.org/pods/RTWebService)
[![License](https://img.shields.io/cocoapods/l/RTWebService.svg?style=flat)](http://cocoapods.org/pods/RTWebService)
[![iOS](https://img.shields.io/badge/iOS-8.0%2B-blue.svg)](http://cocoapods.org/pods/RTWebService)
[![Xcode](https://img.shields.io/badge/Xcode-8.2%2B-blue.svg)](http://cocoapods.org/pods/RTWebService)
[![Swift](https://img.shields.io/badge/Swift-3.0%2B-blue.svg)](http://cocoapods.org/pods/RTWebService)
 

## Introduction

RTWebService is a wrapper around Alamofire for making **REST** and **SOAP** call in easiest possible way. RTWebService also focus on connecting to server by other protocol such as **SSH** and **FTP**.  Right now we are in beta phase of developing this library and soon we will come up with pretty impressive way of communicate with server from your iOS application.

## Installation

RTWebService is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RTWebService"
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Usage 
###1. Rest GET (JSON formatted Response)

``` swift
        
       /*
       //Get single user
        let payload = RTPayload.init(parameter:nil, parameterEncoding:.defaultUrl)
        let req = RTRequest.init(requestUrl: "https://reqres.in/api/users/2",
                                 requestMethod: .get,
                                 header: ["language":"en"],
                                 payload: payload)
       */
        //Get user list
        let payload = RTPayload.init(parameter: ["page":2], parameterEncoding:.defaultUrl)
        let req = RTRequest.init(requestUrl: "https://reqres.in/api/user",
                                 requestMethod: .get,
                                 header: ["language":"en"],
                                 payload: payload)

        RTWebService.restCall(request: req) { (response) in
            print("actual output ------------------------")
            switch response {
            case .success(let res):
                    print("response value")
                    print(res)
            case .failure(let error):
                    print("error value")
                    print(error)
            
            }
        }
```
In this sample uses every thing is pretty simple to understand except the **parameterEncoding**. *.defaultUrl* will send your query parameter as urlEncoding such as  **http://demo0947187.mockable.io/get?name=rajan**

###2. Rest POST (JSON formatted Response)

Form Data: Create user
```bash
$ curl -i \
	-X POST \
	-H "language: en" \
	-H "User-Agent: RTWebService_Example/1.0 (org.cocoapods.demo.RTWebService-Example; build:1; iOS 10.2.0) Alamofire/4.3.0" \
	-d "job=leader&name=morpheus" \
	"https://reqres.in/api/users"
```
```swift 
        let payload = RTPayload.init(parameter: ["name": "morpheus",
                                                 "job": "leader"], parameterEncoding:.bodyUrl)
        let req = RTRequest.init(requestUrl: "https://reqres.in/api/users",
                                 requestMethod: .post,
                                 header: ["language":"en"],
                                 payload: payload)
```

JSON formatted Body Data
```bash
$ curl -i \
	-X POST \
	-H "language: en" \
	-H "User-Agent: RTWebService_Example/1.0 (org.cocoapods.demo.RTWebService-Example; build:1; iOS 10.2.0) Alamofire/4.3.0" \
        -d "{\"job\":\"leader\",\"name\":\"morpheus\"}" \
	"https://reqres.in/api/users"
```
```swift 
        let payload = RTPayload.init(parameter: ["name": "morpheus",
                                                 "job": "leader"], parameterEncoding:.defaultJson)
        let req = RTRequest.init(requestUrl: "https://reqres.in/api/users",
                                 requestMethod: .post,
                                 header: ["language":"en"],
                                 payload: payload)
```

XML formatted Body Data
```bash
$ curl -i \
	-X POST \
	-H "language: en" \
	-H "User-Agent: RTWebService_Example/1.0 (org.cocoapods.demo.RTWebService-Example; build:1; iOS 10.2.0) Alamofire/4.3.0" \
        -d "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
            <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
           <plist version=\"1.0\">
            <dict>
	     <key>job</key>
	     <string>leader</string>
	     <key>name</key>
	     <string>morpheus</string>
           </dict>
          </plist>" \
	"https://reqres.in/api/users"
```
```swift 
        let payload = RTPayload.init(parameter: ["name": "morpheus",
                                                 "job": "leader"], parameterEncoding:.xmlProperty)
        let req = RTRequest.init(requestUrl: "https://reqres.in/api/users",
                                 requestMethod: .post,
                                 header: ["language":"en"],
                                 payload: payload)
```




##1. SOAP Web Service Handling
TO make a soap call we need to have following things setup before making a service call
* Host address
* SOAP Action
* SOAP Message Body

[Webservicex](http://www.webservicex.net/) have tons of soap request to work with. 

### Soap Get Request
```swift
let soapPayload = RTPayload(parameter: ["IPAddress" : "124.41.219.215"], parameterEncoding: .defaultUrl)
        let req1 = RTRequest.init(requestUrl: "http://www.webservicex.net//geoipservice.asmx/GetGeoIP",
                                  requestMethod: .get,
                                  header: ["language":"en",
                                           "Content-Type": "text/xml"],
                                  payload: soapPayload)
        
        RTWebService.soapCall(request: req1) { (response) in
            print("actual output ------------------------")
            switch response {
            case .success(let res):
                print("response value")
                print(res)
            case .failure(let error):
                print("error value")
                print(error)
                
            }
        }

```

### Soap Post Request

Let's make a SOAP request with following  request configuration

```xml
POST /geoipservice.asmx HTTP/1.1
Host: www.webservicex.net
Content-Type: text/xml; charset=utf-8
Content-Length: length
SOAPAction: "http://www.webservicex.net/GetGeoIP"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetGeoIP xmlns="http://www.webservicex.net/">
      <IPAddress>string</IPAddress>
    </GetGeoIP>
  </soap:Body>
</soap:Envelope>
```

Now with RTWebservice
```swift
// Create XML Document
        let soap = AEXMLDocument()
        let envelope = soap.addChild(name: "soap:Envelope",
                                     attributes: ["xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance",
                                                  "xmlns:xsd":"http://www.w3.org/2001/XMLSchema",
                                                  "xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"])
        
        //let header = envelope.addChild(name: "soap:Header")
        let body = envelope.addChild(name: "soap:Body")
        let geoIp = body.addChild(name:"GetGeoIP", attributes:["xmlns":"http://www.webservicex.net/"])
        geoIp.addChild(name: "IPAddress", value: "124.41.219.215", attributes: [:])
        
 
        
        
        let soapPayload = RTPayload(parameter: ["soapdata" : soap.xml], parameterEncoding: .defaultUrl)
        let req1 = RTRequest.init(requestUrl: "http://www.webservicex.net/geoipservice.asmx",
                                 requestMethod: .post,
                                 header: ["language":"en",
                                          "SOAPAction":"http://www.webservicex.net/GetGeoIP",
                                          "length": String(soap.xml.characters.count),
                                          "Content-Type": "text/xml"],
                                 payload: soapPayload)
        
 
        
    
        
        RTWebService.soapCall(request: req1) { (response) in
            print("actual output ------------------------")
            switch response {
            case .success(let res):
                print("response value")
                print(res)
            case .failure(let error):
                print("error value")
                print(error)
                
            }
        }
```

## Author
rajan, rajantwnabashu@gmail.com

## Contribution
We welcome any contribution.

## License

RTWebService is available under the MIT license. See the LICENSE file for more info.
