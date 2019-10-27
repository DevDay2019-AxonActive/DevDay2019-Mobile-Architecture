import Foundation

class BooksWorker {
    var booksStore: BooksStoreProtocol
    
    init(booksStore: BooksStoreProtocol)
    {
      self.booksStore = booksStore
    }
    
    func fetchBooks(completionHandler: @escaping ([Book]) -> Void)
    {
      booksStore.fetchBooks { (books: () throws -> [Book]) -> Void in
        do {
            let books = try books()
            completionHandler(books)
        } catch {
            completionHandler([])
        }
      }
    }
    
    func searchBooks(textSearch: String, completionHandler: @escaping ([Book]) -> Void){
        
        booksStore.searchBooks(textSearch: textSearch) { (books: () throws -> [Book]) -> Void in
          do {
            let books = try books()
            completionHandler(books)
          } catch {
              completionHandler([])
          }
        }
    }
}

protocol BooksStoreProtocol
{
  func fetchBooks(completionHandler: @escaping (() throws -> [Book]) -> Void)
  func searchBooks(textSearch: String, completionHandler: @escaping (() throws -> [Book]) -> Void)
}

protocol BooksStoreUtilityProtocol {}

extension BooksStoreUtilityProtocol
{
  func generateOrderID(book: inout Book)
  {
//    guard book.id == nil else { return }
//    book.id = "\(arc4random())"
  }
  
  func calculateOrderTotal(book: inout Book)
  {
//    guard book.total == NSDecimalNumber.notANumber else { return }
//    book.total = NSDecimalNumber.one
  }
    
    
}
enum BooksStoreResult<U>
{
  case Success(result: U)
  case Failure(error: BooksStoreError)
}

enum BooksStoreError: Equatable, Error
{
  case CannotFetch(String)
  case CannotCreate(String)
  case CannotUpdate(String)
  case CannotDelete(String)
}
