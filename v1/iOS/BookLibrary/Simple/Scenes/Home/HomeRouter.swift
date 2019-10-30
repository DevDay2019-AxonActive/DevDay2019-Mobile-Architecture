import UIKit

@objc protocol HomeRoutingLogic
{
  func routeToShowDetail(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing
{
  var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing
{
  weak var viewController: HomeViewController?
  var dataStore: HomeDataStore?
  
  // MARK: Routing
  
  func routeToShowDetail(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! ShowBookViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! ShowBookViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
      navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToSomewhere(source: HomeViewController, destination: ShowBookViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToSomewhere(source: HomeDataStore, destination: inout ShowBookDataStore)
  {
    let selectedRow = viewController?.booksTableView.indexPathForSelectedRow?.row
    destination.book = source.books?[selectedRow!]
  }
}
