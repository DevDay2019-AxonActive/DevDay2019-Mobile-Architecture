import Foundation

let baseUrl = "http://85.214.44.228:8082"

struct GetBooks {
    struct ProductionServer {
        static let url = baseUrl + "/library-core/api/books"
        static let method = ApiMethod.GET.rawValue
    }
    
    struct APIParameterKey {
    }
}

struct Login {
    struct ProductionServer {
        static let url = baseUrl + "/user/login"
        static let method = ApiMethod.GET.rawValue
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let username = "username"
    }
}

struct SearchBook {
    struct ProductionServer {
        static let url = baseUrl + "/library-core/api/books/search"
        static let method = ApiMethod.POST.rawValue
    }
    
    struct APIParameterKey {
        static let keyword = "keyword"
    }
}

struct getCommentByBookId {
    struct ProductionServer {
           static let url = baseUrl + "/library-core/api/book-details/{bookId}/ratings"
           static let method = ApiMethod.GET.rawValue
       }
       
       struct APIParameterKey {
           static let bookId = "bookId"
       }
}

struct addComment {
    struct ProductionServer {
        static let url = baseUrl + "/library-core/api/book-details/{bookDetailId}/comment"
        static let method = ApiMethod.POST.rawValue
    }
    
    struct APIParameterKey {
        static let bookId = "bookDetailId"
        static let comment = ""
        static let parentId = 0
    }
}

struct rateABook {
    struct ProductionServer {
           static let url = baseUrl + "/library-core/api/book-details/{bookDetailId}/ratings"
           static let method = ApiMethod.POST.rawValue
       }
       
       struct APIParameterKey {
           static let bookId = "bookDetailId"
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
