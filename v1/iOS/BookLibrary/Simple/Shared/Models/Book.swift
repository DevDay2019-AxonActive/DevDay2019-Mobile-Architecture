import Foundation
import ObjectMapper

class Book:Mappable, CustomStringConvertible, Equatable {
    
    var id : Int = 0
    var title : String = ""
    var autor : String = ""
    var detail : [BookDetail]?
    
    class BookDetail:Mappable  {
        var coverUrl : String = ""
        //Impl. of Mappable protocol
           required convenience init?(map: Map) {
               self.init()
           }
           
           func mapping(map: Map) {
               coverUrl <- map["coverUrl"]
           }
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.autor == rhs.autor
    }
    
    var description: String {
           var result = "id: \(String(describing: id))\n"
           result += "title: \(String(describing: title))\n"
        result += "coverUrl: \(String(describing: detail?[0].coverUrl))\n"
        
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
        detail <- map["details"]
    }
}
