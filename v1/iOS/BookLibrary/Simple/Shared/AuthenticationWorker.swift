import Foundation

class AuthenticationWorker
{
    
    var authentication:AuthenticationProtocol?
    
    init() {
        self.authentication = nil
    }
    
    init(authentication: AuthenticationProtocol) {
        self.authentication = authentication
    }
    
    func login(username: String, password: String, completionHandler: @escaping (Bool)-> Void) {
        authentication?.login(username: username, password: password) { (success) in
            completionHandler(success)
        }
    }
    
    func saveUserID(_ userID: String?)
    {
        UserDefaults.standard.set(userID, forKey: "userID")
    }
    
    func getUserID() -> String?
    {
        return UserDefaults.standard.string(forKey: "userID")
    }
}


protocol AuthenticationProtocol {
    func login(username: String, password: String, completionHandler: @escaping (Bool)-> Void)
}

