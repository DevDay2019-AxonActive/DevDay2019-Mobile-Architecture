import UIKit

protocol ShowBookDisplayLogic: class
{
  func displayBook(viewModel: ShowBook.GetBook.ViewModel)
}

class ShowBookViewController: UIViewController, ShowBookDisplayLogic
{
    
    @IBOutlet weak var tblBookInfo: UITableView!
    
  var interactor: ShowBookBusinessLogic?
  var router: (NSObjectProtocol & ShowBookRoutingLogic & ShowBookDataPassing)?

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
    let interactor = ShowBookInteractor()
    let presenter = ShowBookPresenter()
    let router = ShowBookRouter()
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
   
    tblBookInfo.estimatedRowHeight = 50
    tblBookInfo.rowHeight = UITableView.automaticDimension
    showInfo()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    
    var book: ShowBook.GetBook.ViewModel.DisplayedBookDetail?
  
  func showInfo()
  {
    let request = ShowBook.GetBook.Request()
    interactor?.doSomething(request: request)
  }
  
 func displayBook(viewModel: ShowBook.GetBook.ViewModel) {
    book = viewModel.displayedBookDetail
    tblBookInfo.reloadData()
    //show info
  }
}


class InfoCell: UITableViewCell {
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    override func layoutSubviews() {
        super.layoutSubviews()
        ratingView.backgroundColor = UIColor.clear
        ratingView.contentMode = UIView.ContentMode.scaleAspectFit
        ratingView.type = .floatRatings
    }
    
    func bindingData(floatDelegate: FloatRatingViewDelegate, book: ShowBook.GetBook.ViewModel.DisplayedBookDetail) {
        ratingView.delegate = floatDelegate
        self.lblName.text = book.title
        self.lblSource.text = book.author
        self.lblDescription.text = "\(String(describing: book.description)) \(String(describing: book.title)) \(String(describing: book.title))"
        
        if(!(book.coverUrl.isEmpty)) {
            let url = URL(string: book.coverUrl)!
            let image =  UIImage(named: "book")
            self.imgCover.kf.setImage(with: url, placeholder: image)
        }
    }
}

extension ShowBookViewController: FloatRatingViewDelegate {

    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        print("rating")
//        liveLabel.text = String(format: "%.2f", self.floatRatingView.rating)
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        print("rating2")
        interactor.rating(rating)
//        updatedLabel.text = String(format: "%.2f", self.floatRatingView.rating)
    }
    
}

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var lblComment: UILabel!
}

extension ShowBookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoCell
            if cell == nil {
              cell = InfoCell(style: .value1, reuseIdentifier: "infoCell")
            }
            
            if let book = self.book {
                cell?.bindingData(floatDelegate: self, book: book)
            }
            return cell!
        } else {
             var cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell
              if cell == nil {
                cell = CommentCell(style: .value1, reuseIdentifier: "commentCell")
              }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
}
