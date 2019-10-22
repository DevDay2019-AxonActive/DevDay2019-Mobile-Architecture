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
  
  // MARK: Login
  
  func login(request: Welcome.Login.Request)
  {
    let userID = request.userID
    let password = request.password
    let authenticationWorker = AuthenticationWorker()
    if authenticationWorker.login(userID: userID, password: password) {
      authenticationWorker.saveUserID(request.userID)
      let response = Welcome.Login.Response(success: true)
      presenter?.presentLogin(response: response)
    } else {
      let response = Welcome.Login.Response(success: false)
      presenter?.presentLogin(response: response)
    }
  }
}
