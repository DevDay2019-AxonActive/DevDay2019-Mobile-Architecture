//
//  HomeInteractor.swift
//  Simple
//
//  Created by Raymond Law on 6/25/18.
//  Copyright (c) 2018 Clean Swift LLC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeBusinessLogic
{
  func showGreeting(request: Home.ShowGreeting.Request)
  func fetchBooks()
  func filterContentForSearchText(_ searchText: String)
}

protocol HomeDataStore
{
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
  var presenter: HomePresentationLogic?
  var worker: HomeWorker?
  var ordersWorker = BooksWorker(booksStore: BooksApi())
    
  var books: [Book] = []
  
  // MARK: Show greeting
  
  func showGreeting(request: Home.ShowGreeting.Request)
  {
    let userID = AuthenticationWorker().getUserID()
    let response = Home.ShowGreeting.Response(userID: userID)
    presenter?.presentShowGreeting(response: response)
  }
    
  func fetchBooks()
  {
    ordersWorker.fetchBooks{(books) -> Void in
        self.books = books
        let response = Home.FetchBook.Response(books: books)
        self.presenter?.presentFetchedBooks(response: response)
    }
  }
    
    func filterContentForSearchText(_ searchText: String) {
        if(searchText.isEmpty) {
            let response = Home.FetchBook.Response(books: books)
            self.presenter?.presentFetchedBooks(response: response)
            return
        }
         let filteredBooks = books.filter { (candy: Book) -> Bool in
            return candy.title.lowercased().contains(searchText.lowercased())
         }
         let response = Home.FetchBook.Response(books: filteredBooks)
        self.presenter?.presentFetchedBooks(response: response)
       }
}