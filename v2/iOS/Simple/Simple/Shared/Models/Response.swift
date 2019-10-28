import Foundation
import ObjectMapper

class Response<T: Mappable>: Mappable {
    var status: String?
    var code: Int?
    var message: String?
    var data: T?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
    
    func isSuccessCode() -> Bool? {
        return code == 200
    }
}
