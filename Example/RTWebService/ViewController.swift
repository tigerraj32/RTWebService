//
//  ViewController.swift
//  RTWebService
//
//  Created by rajan on 01/23/2017.
//  Copyright (c) 2017 rajan. All rights reserved.
//

import UIKit
import RTWebService

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let payload = RTPayload.init(parameter: ["limit":100, "offset":0, "path":"", "user_id":"57ed03d52d95e54e568652b0"], parameterEncoding:.defaultUrl)
        let req = RTRequest.init(requestUrl: "http://uatbdmobile.com:3001/api/bd/assets",
                                 requestMethod: .get,
                                 header: ["language":"en", "device-type":"ios","api-key":"4c523dc68c1c727b2bb3ad069a31db31672be2b87e353afebbcfacc9f9ed9c77b2a260ece3a097e6405422b5e293a0fa67df014ab65136e3f1640907fad072dc"],
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
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

