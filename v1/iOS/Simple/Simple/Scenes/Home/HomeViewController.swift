import UIKit

protocol HomeDisplayLogic: class
{
  func displayShowGreeting(viewModel: Home.ShowGreeting.ViewModel)
  func displayFetchedBooks(viewModel: Home.FetchBook.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic
{

  @IBOutlet weak var booksTableView: UITableView!
    
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    var displayedBooks: [Home.FetchBook.ViewModel.DisplayedBook] = []
    let searchController = UISearchController(searchResultsController: nil)
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
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
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
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Books"
    searchController.hidesBottomBarWhenPushed = true
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = true
    definesPresentationContext = true
    searchController.searchBar.delegate = self
    
    booksTableView.estimatedRowHeight = 50
    booksTableView.rowHeight = UITableViewAutomaticDimension
    
    showGreeting()
  }
  
  // MARK: Show greeting
  
  func showGreeting()
  {
    let request = Home.ShowGreeting.Request()
    interactor?.showGreeting(request: request)
    interactor?.fetchBooks()
  }
  
  func displayShowGreeting(viewModel: Home.ShowGreeting.ViewModel)
  {
    if let userID = viewModel.userID {
        print("Hello, \(userID)")
    }
  }
    
    
    func displayFetchedBooks(viewModel: Home.FetchBook.ViewModel)
    {
      displayedBooks = viewModel.displayedBooks
      booksTableView.reloadData()
    }
}

class BookCell: UITableViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell
        if cell == nil {
          cell = BookCell(style: .value1, reuseIdentifier: "bookCell")
        }
        cell?.bookTitleLabel.text = displayedBooks[indexPath.row].title
        
        let coverStr = displayedBooks[indexPath.row].coverUrl!
        let url = NSURL(string: coverStr)!
        let request = NSMutableURLRequest(url: url as URL)
        let session = URLSession.shared

        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print("error: \(error!.localizedDescription): \(String(describing: error))")
            }
            else if data != nil {
                DispatchQueue.main.async() {
                    cell?.imgCover.image  = UIImage(data: data!)
                }
            }

        }
        task.resume()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }
}

extension HomeViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
//    let searchBar = searchController.searchBar
//    self.interactor?.filterContentForSearchText(searchBar.text!)
  }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search")
        if let text = searchBar.text {
            self.interactor?.searchBooks(text)
        }
    }
}
