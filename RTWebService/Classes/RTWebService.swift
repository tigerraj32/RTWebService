
import Alamofire
import Foundation


extension DataRequest {
    public func debugLog() -> Self {
        debugPrint(self)
        return self
    }
}

//extension DefaultDataResponse {
//    func debugLog()->Void{
//        #if DEBUG
//            debugPrint(self)
//        #endif
//    }
//}

extension DataResponse {
    func debugLog()->Void{
        debugPrint(self)
    }
}


public enum RTResult<Value> {
    case success(Value)
    case failure(Error)
}
public struct RTResponse {
    let response:[String: Any]?
}

public class RTWebService {
    
    @discardableResult
    public class  func restCall(request: RTRequest){
        Alamofire.request(request.requestUrl,
                          method: request.requestMethod,
                          parameters: request.payload?.parameter,
                          encoding: (request.payload?.parameterEncoding)!,
                          headers: request.header)
                        .debugLog()
                        .responseJSON { (response) in
                            response.debugLog()
                            print(response.result.error)
                            print(response.result.value)
        }
        
      
    }
    
}




