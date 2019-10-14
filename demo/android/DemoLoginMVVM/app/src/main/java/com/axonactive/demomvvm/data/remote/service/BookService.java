package com.axonactive.demomvvm.data.remote.service;

import com.axonactive.demomvvm.data.model.Book;
import com.axonactive.demomvvm.data.model.SearchBookRequest;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface BookService {
    @POST("library-core/api/books/search")
    public Call<List<Book>> searchBook(@Body SearchBookRequest body);
}
