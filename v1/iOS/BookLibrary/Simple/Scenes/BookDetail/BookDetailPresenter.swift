import UIKit

protocol BookDetailPresentationLogic
{
  func presentSomething(response: BookDetail.Something.Response)
}

class BookDetailPresenter: BookDetailPresentationLogic
{
  weak var viewController: BookDetailDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: BookDetail.Something.Response)
  {
    let viewModel = BookDetail.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
