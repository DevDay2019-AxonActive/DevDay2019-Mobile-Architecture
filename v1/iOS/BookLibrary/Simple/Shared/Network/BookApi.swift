import Foundation
import Alamofire
import ObjectMapper

class BooksApi: BooksStoreProtocol, BooksStoreUtilityProtocol
{
  
    func fetchBooks(completionHandler: @escaping (() throws -> [Book]) -> Void) {
        let url = GetBooks.ProductionServer.url
        Alamofire.request(url, method: .get)
            .responseJSON { (reponse) in
                    switch reponse.result {
                    case .success(let value):
                        // Handler Login Success
                        let books = self.transformFromJSON(value)
                        completionHandler {return books}
                        print(books as Any)
                        
                    case .failure(let error):
                        // Handler Login Failure
                        print(error)
                    }
            }
    }
    
    func transformFromJSON(_ value: Any?) -> [Book] {
        if let books = value as? [[String: Any]] {
           return Mapper<Book>().mapArray(JSONArray: books)
        }
        return []
    }
    
    func searchBooks(textSearch: String, completionHandler: @escaping (() throws -> [Book]) -> Void) {
        let url = GetBooks.ProductionServer.searchURL
        var request = URLRequest(url:NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 3600000 
        let values = ["keyword": textSearch]
        request.httpBody = try! JSONSerialization.data(withJSONObject: values, options: [])
        Alamofire.request(request as URLRequestConvertible).responseJSON { (reponse) in
                      switch reponse.result {
                      case .success(let value):
                          let books = self.transformFromJSON(value)
                          completionHandler {return books}
                          print(books as Any)
                          
                      case .failure(let error):
                          print(error)
                      }
              }
      }

}
