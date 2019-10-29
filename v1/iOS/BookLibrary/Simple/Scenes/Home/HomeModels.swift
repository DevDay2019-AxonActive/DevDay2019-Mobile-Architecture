import UIKit

enum Home
{
  // MARK: Use cases
  
    enum ShowGreeting
    {
    struct Request
    {
    }
    struct Response
    {
      var userID: String?
    }
    struct ViewModel
    {
      var userID: String?
    }
    }
    
    enum FetchBook
    {
      struct Request
      {
      }
      struct Response
      {
        var books: [Book]
      }
      struct ViewModel
      {
        struct DisplayedBook
         {
            var title: String = ""
            var coverUrl: String = ""
            var author: String = ""
            
         }
         var displayedBooks: [DisplayedBook]
        
        }
    }
}
