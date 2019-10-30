import UIKit

protocol WelcomeBusinessLogic
{
  func login(request: Welcome.Login.Request)
}

protocol WelcomeDataStore
{
}

class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore
{
  var presenter: WelcomePresentationLogic?
  var worker: WelcomeWorker?
  var authenticationWorker = AuthenticationWorker(authentication: LoginApi())
  
  // MARK: Login
  
  func login(request: Welcome.Login.Request)
  {
    let userID = request.userID
    let password = request.password
    authenticationWorker.login(username: userID!, password: password!) { (success: Bool) in
        if success {
            let response = Welcome.Login.Response(success: true)
            self.presenter?.presentLogin(response: response)
            
        }else{
            let response = Welcome.Login.Response(success: false)
            self.presenter?.presentLogin(response: response)
            
        }
    }
    
  }
}
