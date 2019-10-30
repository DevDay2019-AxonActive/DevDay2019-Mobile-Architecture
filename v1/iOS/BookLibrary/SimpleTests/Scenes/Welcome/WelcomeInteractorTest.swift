@testable import Simple
import XCTest

class WelcomeInteractorTest : XCTestCase
{
    // MARK: - Subject under test
    
    var sut: WelcomeInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupWelcomeInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupWelcomeInteractor()
    {
        sut = WelcomeInteractor()
    }
    
    // MARK: - Test doubles
    
    class WelcomePresentationLogicSpy: WelcomePresentationLogic
    {
        
        // MARK: Method call expectations
        
        var presentLoginCalled = false
        
        // MARK: Spied methods
        
        func presentLogin(response: Welcome.Login.Response) {
            presentLoginCalled = true
        }
    }
    
    class AuthenticationWorkerSpy : AuthenticationWorker
    {
        // MARK: Method call expectations
        
        var loginCalled = false
        
        // MARK: Argument expectations
        
        var username = ""
        var password = ""
        
        // MARK: Spied methods
        
        override func login(username: String, password: String, completionHandler: @escaping (Bool) -> Void) {
            self.username = username
            self.password = password
            loginCalled = true
            completionHandler(true)
        }
    }
    
    // MARK: - Tests
    
    func testLogin_ShouldAskAuthenticationWorkerToLogin()
    {
        // Given
        let welcomePresentationLogicSpy = WelcomePresentationLogicSpy()
        sut.presenter = welcomePresentationLogicSpy
        let authencationWorkerSky = AuthenticationWorkerSpy()
        sut.authenticationWorker = authencationWorkerSky
        
        // When
        sut.login(request: Welcome.Login.Request(
            userID: "simple",
            password: "123"
        ))
        
        // Then
        XCTAssertEqual(authencationWorkerSky.username, "simple", "Login() should pass username to AuthenticationWorker")
        XCTAssertEqual(authencationWorkerSky.password, "123", "Login() should pass passwork to AuthenticationWorker")
        XCTAssert(authencationWorkerSky.loginCalled, "Login() should ask AuthenticationWorker to login")
        XCTAssert(welcomePresentationLogicSpy.presentLoginCalled, "Login() should ask presenter to format login result")
    }
}
