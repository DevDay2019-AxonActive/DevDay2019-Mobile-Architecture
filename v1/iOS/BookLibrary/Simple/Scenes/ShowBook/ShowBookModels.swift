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
            struct DisplayedBookDetail {
                var title: String = ""
                var coverUrl: String = ""
                var author: String = ""
                var description: String = ""
            }
            
            var displayedBookDetail: DisplayedBookDetail?
        }
    }
    
    enum Rating {
        struct Request
        {
        }
        struct Response
        {
            var book: Book?
        }
        struct ViewModel
        {
        }
    }
    
    enum Comment {
        struct Request
        {
        }
        struct Response
        {
            var book: Book?
        }
        struct ViewModel
        {
        }
    }
    
    enum GetCommand
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
            struct DisplayedBookDetail {
                var title: String = ""
                var coverUrl: String = ""
                var author: String = ""
                var description: String = ""
            }
            
            var displayedBookDetail: DisplayedBookDetail?
        }
    }
}
