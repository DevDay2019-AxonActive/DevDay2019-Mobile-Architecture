import UIKit

protocol ShowBookPresentationLogic
{
  func presentSomething(response: ShowBook.Something.Response)
}

class ShowBookPresenter: ShowBookPresentationLogic
{
  weak var viewController: ShowBookDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ShowBook.Something.Response)
  {
    let viewModel = ShowBook.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
