import UIKit

protocol BookDetailBusinessLogic
{
  func doSomething(request: BookDetail.Something.Request)
}

protocol BookDetailDataStore
{
  //var name: String { get set }
}

class BookDetailInteractor: BookDetailBusinessLogic, BookDetailDataStore
{
  var presenter: BookDetailPresentationLogic?
  var worker: BookDetailWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: BookDetail.Something.Request)
  {
    worker = BookDetailWorker()
    worker?.doSomeWork()
    
    let response = BookDetail.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
