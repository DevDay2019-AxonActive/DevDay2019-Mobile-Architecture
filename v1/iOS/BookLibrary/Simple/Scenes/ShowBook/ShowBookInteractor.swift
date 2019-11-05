import UIKit

protocol ShowBookBusinessLogic
{
    func doSomething(request: ShowBook.GetBook.Request)
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
    
    func doSomething(request: ShowBook.GetBook.Request)
    {
        worker = ShowBookWorker()
        worker?.doSomeWork()
        
        let response = ShowBook.GetBook.Response(book: book)
        presenter?.presentBook(response: response)
    }
}
