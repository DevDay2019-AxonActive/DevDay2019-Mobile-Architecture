package com.axonactive.demomvvm.data.repository;

import android.util.Log;

import com.axonactive.demomvvm.data.remote.RetrofitInstance;
import com.axonactive.demomvvm.data.model.Book;
import com.axonactive.demomvvm.data.model.SearchBookRequest;
import com.axonactive.demomvvm.data.remote.service.BookService;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class BookRepository {

    public Call<List<Book>> searchBook(String keyword) {
       return RetrofitInstance.getRetrofit().create(BookService.class).searchBook(new SearchBookRequest(keyword));
    }
}
