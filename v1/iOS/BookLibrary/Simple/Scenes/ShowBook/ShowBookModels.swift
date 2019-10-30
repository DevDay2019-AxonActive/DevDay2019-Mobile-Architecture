import UIKit

enum ShowBook
{
  // MARK: Use cases
  
  enum GetBook
  {
    struct Request
    {
    }
    struct Response
    {
        var book: Book?
    }
    struct ViewModel
    {
        var book: Book?
    }
  }
}
