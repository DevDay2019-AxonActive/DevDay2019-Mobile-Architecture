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
    let book = response.book!
    
    if let coverStr = book.detail?[0].coverUrl {
        let displayedBook = ShowBook.GetBook.ViewModel.DisplayedBookDetail(
            title: book.title,
            coverUrl: coverStr,
            author: book.author,
            description: book.description
        )
        let viewModel = ShowBook.GetBook.ViewModel(displayedBookDetail: displayedBook)
        viewController?.displayBook(viewModel: viewModel)
    }
  }
}
