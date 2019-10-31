import Foundation
import Alamofire

class LoginApi:AuthenticationProtocol {
    func login(username: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        let url = GetBooks.ProductionServer.loginURL + "?password=\(password)&username=\(username)"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let dict = (value as! [String:Any])
                if dict["username"] != nil {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            case .failure(let error):
                print(error)
                completionHandler(false)
            }
        }
    }
    
}