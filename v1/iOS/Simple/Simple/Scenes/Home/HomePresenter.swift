import UIKit

protocol HomePresentationLogic
{
    func presentShowGreeting(response: Home.ShowGreeting.Response)
     func presentFetchedBooks(response: Home.FetchBook.Response)
}

class HomePresenter: HomePresentationLogic
{
  weak var viewController: HomeDisplayLogic?
  
  // MARK: Show greeting
  
    func presentShowGreeting(response: Home.ShowGreeting.Response)
    {
    let viewModel = Home.ShowGreeting.ViewModel(userID: response.userID)
    viewController?.displayShowGreeting(viewModel: viewModel)
    }
    
    func presentFetchedBooks(response: Home.FetchBook.Response)
    {
      var displayedBooks: [Home.FetchBook.ViewModel.DisplayedBook] = []
      for book in response.books {
        let displayedBook = Home.FetchBook.ViewModel.DisplayedBook(title: "\(book.title) \(book.autor)")
        displayedBooks.append(displayedBook)
      }
      let viewModel = Home.FetchBook.ViewModel(displayedBooks: displayedBooks)
      viewController?.displayFetchedBooks(viewModel: viewModel)
    }
}
