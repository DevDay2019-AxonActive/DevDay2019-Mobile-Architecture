import UIKit

@objc protocol WelcomeRoutingLogic
{
  func routeToHome(segue: UIStoryboardSegue?)
}

protocol WelcomeDataPassing
{
  var dataStore: WelcomeDataStore? { get }
}

class WelcomeRouter: NSObject, WelcomeRoutingLogic, WelcomeDataPassing
{
  weak var viewController: WelcomeViewController?
  var dataStore: WelcomeDataStore?
  
  // MARK: Routing
  
  func routeToHome(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! HomeViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToHome(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToHome(source: dataStore!, destination: &destinationDS)
      navigateToHome(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToHome(source: WelcomeViewController, destination: HomeViewController)
  {
  }
  
  // MARK: Passing data
  
  func passDataToHome(source: WelcomeDataStore, destination: inout HomeDataStore)
  {
  }
}
