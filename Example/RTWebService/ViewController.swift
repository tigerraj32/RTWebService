//
//  ViewController.swift
//  RTWebService
//
//  Created by Rajan Twanabashu on 01/23/2017.
//  Copyright (c) 2017 Rajan Twanabashu. All rights reserved.
//

import UIKit
import RTWebService
import AEXML


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
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
        
        */
 
        
        //SOAP Call
        
        
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

