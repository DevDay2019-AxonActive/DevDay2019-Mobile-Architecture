import Foundation

let baseUrl = "http://192.168.70.59:8080/library-core/api/"

struct GetBooks {
    struct ProductionServer {
        static let url = baseUrl + "books"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
    }
}

struct SearchBook {
    struct ProductionServer {
        static let url = "http://192.168.70.59:8080/library-core/api/books"
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
