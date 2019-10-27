import Foundation

class AuthenticationWorker
{
  
    var authenticationProtocol:AuthenticationProtocol?
    
    init() {
        self.authenticationProtocol = nil
    }
    
    init(authenticationProtocol: AuthenticationProtocol) {
        self.authenticationProtocol = authenticationProtocol
    }
  
    func login(username: String, password: String, completionHandler: @escaping (Bool)-> Void) {
        authenticationProtocol?.login(username: username, password: password) { (success) in
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

