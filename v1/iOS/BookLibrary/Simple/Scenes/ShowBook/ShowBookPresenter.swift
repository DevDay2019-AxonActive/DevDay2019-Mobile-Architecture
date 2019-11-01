import UIKit

protocol ShowBookPresentationLogic
{
  func presentBook(response: ShowBook.GetBook.Response)
}

class ShowBookPresenter: ShowBookPresentationLogic
{
  weak var viewController: ShowBookDisplayLogic?
  
  // MARK: Do something
  
  func presentBook(response: ShowBook.GetBook.Response)
  {
    let viewModel = ShowBook.GetBook.ViewModel(book: response.book)
    viewController?.displayBook(viewModel: viewModel)
  }
}
