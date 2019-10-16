package com.aavn.devday.booklibrary.data.repository;

import com.aavn.devday.booklibrary.data.remote.RetrofitInstance;
import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.SearchBookRequest;
import com.aavn.devday.booklibrary.data.remote.service.BookService;

import java.util.List;

import retrofit2.Call;

public class BookRepository {

    public Call<List<Book>> searchBook(String keyword) {
       return RetrofitInstance.getRetrofit().create(BookService.class).searchBook(new SearchBookRequest(keyword));
    }

    public Call<List<Book>> getDefaultBook() {
        return RetrofitInstance.getRetrofit().create(BookService.class).getDefaultBook();
    }

}
