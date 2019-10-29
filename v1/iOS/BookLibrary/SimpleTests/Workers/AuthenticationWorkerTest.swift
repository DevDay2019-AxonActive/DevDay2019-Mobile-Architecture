@testable import Simple
import XCTest

class AuthenticationWorkerTest: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: AuthenticationWorker!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
      super.setUp()
      setupAuthenticationWorker()
    }
    
    override func tearDown()
    {
      super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupAuthenticationWorker()
    {
        sut = AuthenticationWorker(authentication: AuthenticationLogicSpy())
    }
    
    // MARK: - Test doubles
    
    class AuthenticationLogicSpy: AuthenticationProtocol
    {
        // MARK: Method call expections
        
        var loginCalled = false
        
        // MARK: Spied methods
        
        func login(username: String, password: String, completionHandler: @escaping (Bool) -> Void) {
            loginCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler(true)
            }
        }
    }
    
    // MARK: - Tests
    
    func testLogin() {
        // Given
        let authenticationLogicSpy =  sut.authentication as!  AuthenticationLogicSpy
        
        // When
        let expect = expectation(description: "Wait for login() to return")
        sut.login(username: "simple", password: "123") {(isSuccess) in
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        
        // Then
        XCTAssert(authenticationLogicSpy.loginCalled, "Calling login() should ask the api for login")
        
    }
}
