import Foundation

let baseUrl = "http://85.214.44.228:8082"

struct GetBooks {
    struct ProductionServer {
        static let url = baseUrl + "/library-core/api/books"
    }
    
    struct APIParameterKey {
    }
}

struct Login {
    struct ProductionServer {
        static let url = baseUrl + "/user/login"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let username = "username"
    }
}

struct SearchBook {
    struct ProductionServer {
        static let url = baseUrl + "/library-core/api/books/search"
    }
    
    struct APIParameterKey {
        static let keyword = "keyword"
    }
}

struct GetComments {
    struct ProductionServer {
        static let url = baseUrl + "/library-core/api/books/search"
    }
    
    struct APIParameterKey {
        static let keyword = "keyword"
    }
}

struct AddComment {
    struct ProductionServer {
        static let url = baseUrl + "/library-core/api/books/search"
    }
    
    struct APIParameterKey {
        static let keyword = "keyword"
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
