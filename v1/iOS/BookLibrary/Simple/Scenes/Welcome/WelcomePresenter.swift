import UIKit

protocol WelcomePresentationLogic
{
    func presentLogin(response: Welcome.Login.Response)
}

class WelcomePresenter: WelcomePresentationLogic
{
    weak var viewController: WelcomeDisplayLogic?
    
    // MARK: Login
    
    func presentLogin(response: Welcome.Login.Response)
    {
        let viewModel = Welcome.Login.ViewModel(success: response.success)
        viewController?.displayLogin(viewModel: viewModel)
    }
}
