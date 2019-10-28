import UIKit

protocol HomeBusinessLogic
{
  func showGreeting(request: Home.ShowGreeting.Request)
  func fetchBooks()
  func filterContentForSearchText(_ searchText: String)
    func searchBooks(_ searchText: String)
}

protocol HomeDataStore
{
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
  var presenter: HomePresentationLogic?
  var worker: HomeWorker?
  var booksWorker = BooksWorker(booksStore: BooksApi())
    
  var books: [Book] = []
  
  // MARK: Show greeting
  
  func showGreeting(request: Home.ShowGreeting.Request)
  {
    let userID = AuthenticationWorker().getUserID()
    let response = Home.ShowGreeting.Response(userID: userID)
    presenter?.presentShowGreeting(response: response)
  }
    
  func fetchBooks()
  {
    booksWorker.fetchBooks{(books) -> Void in
        self.books = books
        let response = Home.FetchBook.Response(books: books)
        self.presenter?.presentFetchedBooks(response: response)
    }
  }
    
    func filterContentForSearchText(_ searchText: String) {
        if(searchText.isEmpty) {
            let response = Home.FetchBook.Response(books: books)
            self.presenter?.presentFetchedBooks(response: response)
            return
        }
         let filteredBooks = books.filter { (candy: Book) -> Bool in
            return candy.title.lowercased().contains(searchText.lowercased())
         }
         let response = Home.FetchBook.Response(books: filteredBooks)
        self.presenter?.presentFetchedBooks(response: response)
       }
    
    func searchBooks(_ searchText: String) {
        booksWorker.searchBooks(textSearch: searchText) { (books) -> Void in
        self.books = books
        let response = Home.FetchBook.Response(books: books)
        self.presenter?.presentFetchedBooks(response: response)
        }
    }
}
