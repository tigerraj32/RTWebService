//
//  Payload.swift
//  Pods
//
//  Created by Javra Software on 24/01/2017.
//
//

import Foundation
import Alamofire


public enum RTEncode  {
    case defaultUrl
    case queryUrl
    case bodyUrl
    case defaultJson
    case prettyJson
    case defaultProperty
    case xmlProperty
    case binaryProperty
    
    static func getEncode(type: RTEncode) -> ParameterEncoding{
        let paramEncode: ParameterEncoding?
        switch type {
            
        case .defaultUrl:
            paramEncode = URLEncoding.default
            
        case .queryUrl:
            paramEncode = URLEncoding.queryString
            
        case .bodyUrl:
            paramEncode = URLEncoding.httpBody
            
        case .defaultJson:
            paramEncode = JSONEncoding.default
            
        case .prettyJson:
            paramEncode = JSONEncoding.prettyPrinted
            
        case .defaultProperty:
            paramEncode = PropertyListEncoding.default
            
        case .xmlProperty:
            paramEncode = PropertyListEncoding.xml
            
        case .binaryProperty:
            paramEncode = PropertyListEncoding.binary
            
        default:
            paramEncode = URLEncoding.default
        }
        return paramEncode!
    }
    
}

public struct RTRequest {
    public let requestUrl: String
    public let requestMethod:HTTPMethod
    public let header: [String: String]?
    public var payload: RTPayload? = RTPayload(parameter: nil, parameterEncoding:.defaultUrl)
   
    public init(requestUrl: String, requestMethod: HTTPMethod, header:[String: String]?, payload: RTPayload?){
        self.requestUrl = requestUrl
        self.requestMethod = requestMethod
        self.header = header!
        self.payload = payload!
    }
}


public struct RTPayload {
    public var parameter: [String: Any]? = nil
    public var parameterEncoding:ParameterEncoding = URLEncoding.default
    
    public init(parameter: [String: Any]?, parameterEncoding: RTEncode) {
        self.parameter = parameter
        self.parameterEncoding = RTEncode.getEncode(type: parameterEncoding)
    }
}


