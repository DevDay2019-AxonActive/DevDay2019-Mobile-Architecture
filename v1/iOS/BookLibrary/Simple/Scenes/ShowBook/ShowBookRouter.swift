import UIKit

@objc protocol ShowBookRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ShowBookDataPassing
{
  var dataStore: ShowBookDataStore? { get }
}

class ShowBookRouter: NSObject, ShowBookRoutingLogic, ShowBookDataPassing
{
  weak var viewController: ShowBookViewController?
  var dataStore: ShowBookDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: ShowBookViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ShowBookDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}