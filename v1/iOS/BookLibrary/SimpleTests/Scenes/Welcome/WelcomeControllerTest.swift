
@testable import Simple
import XCTest

class WelcomeViewControllerTest: XCTestCase
{
    // MARK: - Subject undet test
    
    var sut: WelcomeViewController!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupWelcomeViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupWelcomeViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name:"Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    
    class WelcomeBusinessLogicSpy: WelcomeBusinessLogic
    {
        // MARK: Method call expectations
        
        var loginCalled = false
        
        // MARK: Spied method
        
        func login(request: Welcome.Login.Request) {
            loginCalled = true
        }
    }
    
    class WelcomeRouterSpy: WelcomeRouter
    {
        // MARK: Method call expectations
        
        var routeToHomeCalled = false
        
        // MARK: Spied method
        
        override func routeToHome(segue: UIStoryboardSegue?) {
            routeToHomeCalled = true
        }
    }
    
    // MARK: - Test
    
    func testShouldLogin() {
        // Given
        let welcomeBusinessLogicSpy = WelcomeBusinessLogicSpy()
        sut.interactor = welcomeBusinessLogicSpy
        loadView()
        
        // When
        sut.loginButtonTapped(self)
        
        // Then
        XCTAssert(welcomeBusinessLogicSpy.loginCalled, "It should login when the user taps the Login button")
        
    }
    
    
    func testShouldDisplayLoginSuccess() {
        // Given
        let welcomeRouterSpy = WelcomeRouterSpy()
        sut.router = welcomeRouterSpy
        loadView()
        
        // When
        sut.displayLogin(viewModel: Welcome.Login.ViewModel(success: true)
        )
        
        // Then
        XCTAssert(welcomeRouterSpy.routeToHomeCalled, "Displaying a successfully Welcome should navigate to the Home scene")
    }
}
