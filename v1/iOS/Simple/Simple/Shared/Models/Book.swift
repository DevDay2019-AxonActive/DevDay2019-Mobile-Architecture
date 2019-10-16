//
//  Book.swift
//  Simple
//
//  Created by Dai Doan Van on 10/14/19.
//  Copyright © 2019 Clean Swift LLC. All rights reserved.
//

import Foundation
import ObjectMapper

class Book:Mappable, CustomStringConvertible {
    var id = 0
    var title = ""
    var autor = ""
    var genre = ""
    
    var description: String {
           var result = "id: \(String(describing: id))\n"
           result += "title: \(String(describing: title))\n"
           return result
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
