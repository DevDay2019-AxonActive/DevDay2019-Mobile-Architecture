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
      var searchBooksCalled = false
        
      // MARK: Argument expectations
        
      var textSearch = ""
      
      // MARK: Spied methods
      
      override func fetchBooks(completionHandler: @escaping ([Book]) -> Void)
       {
            fetchBooksCalled = true
            completionHandler([Seeds.Books.amyy, Seeds.Books.boby])
        }
        
      override func searchBooks(textSearch: String, completionHandler: @escaping ([Book]) -> Void) {
            searchBooksCalled = true
        completionHandler([Seeds.Books.amyy, Seeds.Books.boby])
        self.textSearch = textSearch
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
      XCTAssert(booksWorkerSpy.fetchBooksCalled, "FetchBooks() should ask BooksWorker to fetch books")
      XCTAssert(homePresentationLogicSpy.presentFetchedBooksCalled, "FetchBooks() should ask presenter to format books result")
    }
    
    func testSearchBooks_ShouldAskBooksWorkerToSearchBooks()
    {
        // Given
         let homePresentationLogicSpy = HomePresentationLogicSpy()
         sut.presenter = homePresentationLogicSpy
         let booksWorkerSpy = BooksWorkerSpy(booksStore: BooksApi())
         sut.booksWorker = booksWorkerSpy

         // When
         sut.searchBooks("java")

         // Then
        XCTAssertEqual(booksWorkerSpy.textSearch, "java", "SearchBooks() should pass textSearch to BooksWorker to search")
    }
    
    func testSearchBooks_ShouldAskBooksWorkerToSearchBooks_AndPresenterToFormatResult()
    {
      // Given
      let homePresentationLogicSpy = HomePresentationLogicSpy()
      sut.presenter = homePresentationLogicSpy
      let booksWorkerSpy = BooksWorkerSpy(booksStore: BooksApi())
      sut.booksWorker = booksWorkerSpy

      // When
      sut.searchBooks("java")

      // Then
      XCTAssert(booksWorkerSpy.searchBooksCalled, "SearchBooks() should ask BooksWorker to fetch books")
      XCTAssert(homePresentationLogicSpy.presentFetchedBooksCalled, "SearchBooks() should ask presenter to format books result")
    }
}
