import UIKit

protocol ShowBookBusinessLogic
{
  func doSomething(request: ShowBook.Something.Request)
}

protocol ShowBookDataStore
{
  var book: Book! { get set }
}

class ShowBookInteractor: ShowBookBusinessLogic, ShowBookDataStore
{
  var presenter: ShowBookPresentationLogic?
  var worker: ShowBookWorker?
  var book: Book!
  
  // MARK: Do something
  
  func doSomething(request: ShowBook.Something.Request)
  {
    worker = ShowBookWorker()
    worker?.doSomeWork()
    
    let response = ShowBook.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
