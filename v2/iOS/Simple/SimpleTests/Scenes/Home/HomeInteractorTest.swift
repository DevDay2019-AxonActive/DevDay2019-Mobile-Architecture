@testable import Simple
import XCTest

class HomeInteractorTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: HomeInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
      super.setUp()
      setupHomeInteractor()
    }
    
    override func tearDown()
    {
      super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupHomeInteractor()
    {
      sut = HomeInteractor()
    }
    
    // MARK: - Test doubles
    
    class HomePresentationLogicSpy: HomePresentationLogic
    {
        // MARK: Method call expectations
        
        var presentShowGreetingCalled = false
        var presentFetchedBooksCalled = false
        
        // MARK: Spied methods
        
        func presentShowGreeting(response: Home.ShowGreeting.Response) {
            presentShowGreetingCalled = true
        }
        
        func presentFetchedBooks(response: Home.FetchBook.Response) {
            presentFetchedBooksCalled = true
        }
    }
    
    class BooksWorkerSpy: BooksWorker
    {
      // MARK: Method call expectations
      
      var fetchBooksCalled = false
      
      // MARK: Spied methods
      
        override func fetchBooks(completionHandler: @escaping ([Book]) -> Void)
       {
            fetchBooksCalled = true
            completionHandler([Seeds.Books.amyy, Seeds.Books.boby])
        }
    }
    
    // MARK: - Tests
    
    func testFetchBooks_ShouldAskBooksWorkerToFetchBooks_AndPresenterToFormatResult()
    {
      // Given
      let homePresentationLogicSpy = HomePresentationLogicSpy()
      sut.presenter = homePresentationLogicSpy
      let booksWorkerSpy = BooksWorkerSpy(booksStore: BooksApi())
      sut.booksWorker = booksWorkerSpy

      // When
      sut.fetchBooks()

      // Then
      XCTAssert(booksWorkerSpy.fetchBooksCalled, "FetchOrders() should ask BooksWorker to fetch books")
      XCTAssert(homePresentationLogicSpy.presentFetchedBooksCalled, "FetchBooks() should ask presenter to format books result")
    }
}
