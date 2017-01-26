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
        
        let soap = AEXMLDocument()
        let envelope = soap.addChild(name: "soapenv:Envelope",
                                     attributes: ["xmlns:soapenv":"http://schemas.xmlsoap.org/soap/envelope/",
                                                  "xmlns:cat":"NS1/pcacsoap"])
        
        let header = envelope.addChild(name: "soapenv:Header")
        let body = envelope.addChild(name: "soapenv:Body")
        let catInfo = body.addChild(name: "cat:sendcataloginfo")
        let request = catInfo.addChild(name: "cat:request")
        let ttrequest = request.addChild(name: "cat:ttrequest")
        ttrequest.addChild(name: "cat:calltype", value: "category", attributes: [:])
        ttrequest.addChild(name: "cat:code", value: "18,7,0,15,16", attributes: [:])
        
        let soapPayload = RTPayload(parameter: ["soapdata" : soap.xml], parameterEncoding: .custom)
        let req1 = RTRequest.init(requestUrl: "http://catapp.javra.com:8080/pcactest/wsa1",
                                 requestMethod: .post,
                                 header: ["language":"en",
                                          "SOAPAction":"",
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

