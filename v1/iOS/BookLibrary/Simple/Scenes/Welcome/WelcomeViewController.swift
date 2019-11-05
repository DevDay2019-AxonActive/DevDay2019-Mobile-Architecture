import UIKit
import MBProgressHUD

protocol WelcomeDisplayLogic: class
{
    func displayLogin(viewModel: Welcome.Login.ViewModel)
}

class WelcomeViewController: UIViewController, WelcomeDisplayLogic
{
    var interactor: WelcomeBusinessLogic?
    var router: (NSObjectProtocol & WelcomeRoutingLogic & WelcomeDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = WelcomeInteractor()
        let presenter = WelcomePresenter()
        let router = WelcomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: Login
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any)
    {
        login()
    }
    
    func showHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func login()
    {
        self.showHUD()
        let userID = userIDTextField.text
        let password = passwordTextField.text
        let request = Welcome.Login.Request(userID: userID, password: password)
        interactor?.login(request: request)
    }
    
    func displayLogin(viewModel: Welcome.Login.ViewModel)
    {
        self.hideHUD()
        if viewModel.success {
            performSegue(withIdentifier: "Home", sender: nil)
        } else {
            userIDTextField.text = nil
            passwordTextField.text = nil
        }
    }
}
