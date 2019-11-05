@testable import Simple
import XCTest

class HomeViewControllerTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: HomeViewController!
    var window: UIWindow!
    
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupHomeViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    
    class HomeBusinessLogicSpy: HomeBusinessLogic
    {
        
        var books: [Book]?
        
        // MARK: Method call expectations
        
        var fetchBooksCalled = false
        var filterContentForSearchTextCalled = false
        var searchBooks = false
        
        // MARK: Spied methods
        
        func showGreeting(request: Home.ShowGreeting.Request) {
            
        }
        
        func fetchBooks() {
            fetchBooksCalled = true
        }
        
        func filterContentForSearchText(_ searchText: String) {
            filterContentForSearchTextCalled = true
        }
        
        func searchBooks(_ searchText: String) {
            searchBooks = true
        }
    }
    
    class TableViewSpy: UITableView
    {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData()
        {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldFetchBooks_WhenViewDidAppear()
    {
        // Given
        let homeBusinessLogicSpy = HomeBusinessLogicSpy()
        sut.interactor = homeBusinessLogicSpy
        loadView()
        
        // When
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(homeBusinessLogicSpy.fetchBooksCalled, "Should fetch books right after the view appears")
    }
    
    func testShouldDisplayFetchedBooks()
    {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.booksTableView = tableViewSpy
        
        // When
        let displayBooks = [Home.FetchBook.ViewModel.DisplayedBook(title: "abc123")]
        let viewModel = Home.FetchBook.ViewModel(displayedBooks: displayBooks)
        sut.displayFetchedBooks(viewModel: viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched books should reload the table view")
    }
    
    func testShouldConfigureTableViewCellToDisplayBook()
    {
        // Given
        loadView()
        let tableView = sut.booksTableView
        let testDisplayBooks = [Home.FetchBook.ViewModel.DisplayedBook(title: "abc123")]
        sut.displayedBooks = testDisplayBooks
        
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView!, cellForRowAt: indexPath) as! BookCell
        
        // Then
        XCTAssertEqual(cell.bookTitleLabel?.text, "abc123")
    }
    
    func testShouldSearchBooks_WhenUserTapOnSearchKey()
    {
        // Given
        let homeBusinessLogicSpy = HomeBusinessLogicSpy()
        sut.interactor = homeBusinessLogicSpy
        loadView()
        
        // When
        
        
        // Then
        //      XCTAssert(homeBusinessLogicSpy.filterContentForSearchTextCalled, "Should search books when user tap on search key")
    }
    
}
