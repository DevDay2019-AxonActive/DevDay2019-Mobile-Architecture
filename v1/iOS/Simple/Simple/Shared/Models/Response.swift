//
//  Response.swift
//  Simple
//
//  Created by Dai Doan Van on 10/14/19.
//  Copyright © 2019 Clean Swift LLC. All rights reserved.
//

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
