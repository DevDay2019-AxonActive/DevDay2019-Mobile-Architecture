import UIKit
import Kingfisher

protocol HomeDisplayLogic: class
{
  func displayShowGreeting(viewModel: Home.ShowGreeting.ViewModel)
  func displayFetchedBooks(viewModel: Home.FetchBook.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic
{

  @IBOutlet weak var booksTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
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
    booksTableView.rowHeight = UITableView.automaticDimension
    
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
     refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
     booksTableView.addSubview(refreshControl)
    
    showGreeting()
  }
  
    @objc func refresh() {
       // Code to refresh table view
        print("refresh")
        searchController.searchBar.text = ""
        interactor?.fetchBooks()
        refreshControl.endRefreshing()
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
    @IBOutlet weak var sourceLabel: UILabel!
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
        let book = displayedBooks[indexPath.row]
        cell?.bookTitleLabel.text = book.title
        if(!book.coverUrl.isEmpty) {
            let url = URL(string: book.coverUrl)!
            let image =  UIImage(named: "book")
            cell!.imgCover.kf.setImage(with: url, placeholder: image)
        }
        cell?.sourceLabel.text = book.author
        return cell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
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
