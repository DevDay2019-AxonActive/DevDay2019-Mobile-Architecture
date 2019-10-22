@testable import Simple
import XCTest

class HomePresenterTests: XCTestCase
{
  // MARK: - Subject under test
  
  var sut: HomePresenter!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupListOrdersPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupListOrdersPresenter()
  {
    sut = HomePresenter()
  }
  
  // MARK: - Test doubles
  
  class HomeDisplayLogicSpy: HomeDisplayLogic
  {
    
    // MARK: Method call expectations
    
    var displayShowGreetingCalled = false
    var displayFetchedBooksCalled = false
    
    // MARK: Argument expectations
    
    var viewModel: Home.FetchBook.ViewModel!
    
    // MARK: Argument expectations
    
    func displayShowGreeting(viewModel: Home.ShowGreeting.ViewModel) {
        displayShowGreetingCalled = true
    }
    
    func displayFetchedBooks(viewModel: Home.FetchBook.ViewModel) {
        displayFetchedBooksCalled = true
        self.viewModel = viewModel
    }
  }
  
  // MARK: - Tests
  
  func testPresentFetchedBooks_ShouldFormatFetchedBooksForDisplay()
  {
    // Given
    let homeDisplayLogicSpy = HomeDisplayLogicSpy()
    sut.viewController = homeDisplayLogicSpy
    
    // When
    let books = [Seeds.Books.amyy]
    let response = Home.FetchBook.Response(books: books)
    sut.presentFetchedBooks(response: response)
    
    // Then
    let displayedBooks = homeDisplayLogicSpy.viewModel.displayedBooks
    for displayedBook in displayedBooks {
      XCTAssertEqual(displayedBook.title, " ", "Presenting fetched books should properly format book date")
    }
  }
  
  func testPresentFetchedBooks_ShouldAskViewControllerToDisplayFetcheBooks()
  {
    // Given
    let homeDisplayLogicSpy = HomeDisplayLogicSpy()
    sut.viewController = homeDisplayLogicSpy
    
    // When
    let books = [Seeds.Books.amyy]
    let response = Home.FetchBook.Response(books: books)
    sut.presentFetchedBooks(response: response)
    
    // Then
    XCTAssert(homeDisplayLogicSpy.displayFetchedBooksCalled, "Presenting fetched books should ask view controller to display them")
  }
}

