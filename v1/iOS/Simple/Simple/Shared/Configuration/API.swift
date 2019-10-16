//
//  API.swift
//  Simple
//
//  Created by Dai Doan Van on 10/14/19.
//  Copyright © 2019 Clean Swift LLC. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://api.medium.com/v1"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

public enum ApiMethod: String {
    case GET, POST, PATCH, PUT, DELETE
}
