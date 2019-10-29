
@testable import Simple
import XCTest

class WelcomePresenterTest: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: WelcomePresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupWelcomePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupWelcomePresenter()
    {
        sut = WelcomePresenter()
    }
    
    // MARK: - Test doubles
    
    class WelcomeDisplayLogicSpy: WelcomeDisplayLogic
    {
        // MARK: Method call epectations
        
        var displayLoginCalled = false
        
        // MARK: Argument expectations
        
        var viewModel: Welcome.Login.ViewModel!
        
        // MARK: Spied methods
        
        func displayLogin(viewModel: Welcome.Login.ViewModel) {
            self.viewModel = viewModel
            displayLoginCalled = true
        }
    }
    
    // MARK: - Test
    
    func testPresentLogin_ShouldAskViewControllerToDisplay() {
        // Given
        let welcomeDisplayLogicSpy = WelcomeDisplayLogicSpy()
        sut.viewController = welcomeDisplayLogicSpy
        
        // When
        sut.presentLogin(response: Welcome.Login.Response(success: true))
        
        // Then
        XCTAssert(welcomeDisplayLogicSpy.displayLoginCalled, "Presenting login should ask view controller to display them")
        
    }
}
