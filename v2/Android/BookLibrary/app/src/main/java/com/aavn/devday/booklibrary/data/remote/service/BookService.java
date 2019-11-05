package com.aavn.devday.booklibrary.data.remote.service;

import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.aavn.devday.booklibrary.data.model.SearchBookRequest;

import java.util.List;

import io.reactivex.Single;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;

public interface BookService {
    @POST("library-core/api/books/search")
    Single<List<Book>> searchBook(@Body SearchBookRequest body);

    @GET("library-core/api/books")
    Single<List<Book>> getDefaultBook();

    @GET("library-core/api/books/{id}")
    Single<BookDetail> getBookDetail(@Path("id") int bookId);
}
