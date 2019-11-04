import Foundation
import Alamofire
import ObjectMapper

class CommentApi {
    func getCommand(completionHandler: @escaping (() throws -> [Command]) -> Void) {
        let url = GetComments.ProductionServer.url
        var request = URLRequest(url:NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 3600000
//        let values = [SearchBook.APIParameterKey.keyword: textSearch]
//        request.httpBody = try! JSONSerialization.data(withJSONObject: values, options: [])
//        Alamofire.request(request as URLRequestConvertible).responseJSON { (reponse) in
//                      switch reponse.result {
//                      case .success(let value):
//                          let books = self.transformFromJSON(value)
//                          completionHandler {return books}
//                          print(books as Any)
//
//                      case .failure(let error):
//                          print(error)
//                      }
//              }
    }
}
