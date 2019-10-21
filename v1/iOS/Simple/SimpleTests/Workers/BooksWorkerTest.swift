@testable import Simple
import XCTest

class BooksWorkerTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: BooksWorker!
    static var testBooks: [Book]!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupBooksWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupBooksWorker()
    {
        sut = BooksWorker(booksStore: BooksApiSpy())
        
        BooksWorkerTests.testBooks = [Seeds.Books.amyy, Seeds.Books.boby]
    }
    
    // MARK: - Test doubles
    
    class BooksApiSpy: BooksStoreProtocol
    {
        // MARK: Method call expectations
        
        var fetchBooksCalled = true
        
        // MARK: Spied methods
        
        func fetchBooks(completionHandler: @escaping (() throws -> [Book]) -> Void) {
            fetchBooksCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler {() -> [Book] in
                    return BooksWorkerTests.testBooks
                }
            }
        }
    }
    
    // MARK: - Tests
    
    func testFetchBooksShouldReturnListOfBooks()
    {
        // Given
        let booksApiSpy = sut.booksStore as! BooksApiSpy
        
        // When
        var fetchBooks = [Book]()
        let expect = expectation(description: "Wait for fechBooks() to return")
        sut.fetchBooks{(books) in
            fetchBooks = books
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        
        // Then
        XCTAssert(booksApiSpy.fetchBooksCalled, "Calling fetchBooks() should ask the api for list of books")
        XCTAssertEqual(fetchBooks.count, BooksWorkerTests.testBooks.count, "Calling fetchOrders() should return list of books")
        for book in fetchBooks {
            XCTAssert(BooksWorkerTests.testBooks.contains(book), "Fetched books should match the books in the data source")
        }
    }
    
}
