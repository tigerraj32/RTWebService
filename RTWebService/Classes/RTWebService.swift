
import Alamofire
import Foundation


extension DataRequest {
    public func debugLog() -> Self {
        debugPrint(self)
        return self
    }
}

extension DefaultDataResponse {
    func debugLog()->Void{
        #if DEBUG
            debugPrint(self)
        #endif
    }
}

extension DataResponse {
    func debugLog()->Void{
        debugPrint(self)
    }
}

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}


public enum RTResult<Value> {
    case success(Value)
    case failure(Error)
}
public struct RTResponse {
    let response:Any
    init(value: Any) {
        self.response = value
    }
}

public class RTWebService {
    
    @discardableResult
    public class  func restCall(request: RTRequest, onCompletion: @escaping (RTResult<Any>)->Void){
        Alamofire.request(request.requestUrl,
                          method: request.requestMethod,
                          parameters: request.payload?.parameter,
                          encoding: (request.payload?.parameterEncoding)!,
                          headers: request.header)
                        .debugLog()
                        .responseJSON { (response) in
                            //response.debugLog()
                            //print(type(of:response.result.value))
                            switch response.result {
                            case .success:
                                let res = RTResponse(value: response.result.value) as! Any
                                let result = RTResult.success(res)
                                onCompletion(result)
                            case .failure(let error):
                                 onCompletion(RTResult.failure(error))
                            default:
                                 print(response)
                            }
                           
                           
        }
        
      
    }

    @discardableResult
    public class  func soapCall(request: RTRequest, onCompletion: @escaping (RTResult<Any>)->Void){
        
        Alamofire.request(request.requestUrl,
                          method: request.requestMethod,
                          parameters: request.requestMethod == .get ? request.payload?.parameter : [:],
                          encoding: request.requestMethod == .get ? (request.payload?.parameterEncoding)! : request.payload?.parameter?["soapdata"] as! String,
                          headers: request.header)
            .debugLog()
            .responseString{ (response) in
                response.debugLog()
                
                
                
                
        }
        
        
    }
}




