import Foundation
import ObjectMapper

class Book:Mappable, CustomStringConvertible {
    var id : Int = 0
    var title : String = ""
    var autor : String = ""
    var genre : String = ""
    
    var description: String {
           var result = "id: \(String(describing: id))\n"
           result += "title: \(String(describing: title))\n"
           return result
       }
    
    required convenience init(id:Int, title:String, autor:String, genre:String) {
        self.init()
    }
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["name"]
        autor <- map["author"]
        genre <- map["details"]
    }
}
