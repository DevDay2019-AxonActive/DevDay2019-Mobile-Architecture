import UIKit

enum Welcome
{
  // MARK: Use cases
  
  enum Login
  {
    struct Request
    {
      var userID: String?
      var password: String?
    }
    struct Response
    {
      var success: Bool
    }
    struct ViewModel
    {
      var success: Bool
    }
  }
}
