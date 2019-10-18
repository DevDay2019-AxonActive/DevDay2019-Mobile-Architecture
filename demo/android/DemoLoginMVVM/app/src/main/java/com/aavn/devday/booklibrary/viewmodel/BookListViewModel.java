package com.aavn.devday.booklibrary.viewmodel;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.ResponseData;
import com.aavn.devday.booklibrary.data.repository.BookRepository;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class BookListViewModel extends ViewModel {
    private MutableLiveData<ResponseData<List<Book>>> bookListLiveData = new MutableLiveData<>();

    private BookRepository bookRepository;

    public BookListViewModel() {
        bookRepository = new BookRepository();
    }

    public LiveData<ResponseData<List<Book>>> getBookListLiveData() {
        return bookListLiveData;
    }

    public void searchBook(String keyword) {
        bookListLiveData.setValue(ResponseData.loading());
        bookRepository.searchBook(keyword).enqueue(new Callback<List<Book>>() {
            @Override
            public void onResponse(Call<List<Book>> call, Response<List<Book>> response) {
                if (response.isSuccessful()) {
                    bookListLiveData.setValue(ResponseData.success(response.body()));
                } else {
                    bookListLiveData.setValue(ResponseData.error("Can not load book list!"));
                }
            }

            @Override
            public void onFailure(Call<List<Book>> call, Throwable t) {
                bookListLiveData.setValue(ResponseData.error(t.getMessage()));
            }
        });

//        List<Book> dummyBookList = new ArrayList<>();
//        BookDetail dummyBookDetail = new BookDetail("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s");
//        List<BookDetail> dummyBookDetailList = new ArrayList<>();
//        dummyBookDetailList.add(dummyBookDetail);
//        dummyBookList.add(new Book("Effective Java", "Joshua Bloch", dummyBookDetailList));
//        dummyBookList.add(new Book("Head First Java", "Bert Bates and Kathy Sierra", dummyBookDetailList));
//        dummyBookList.add(new Book("Java: A Beginner's Guide", "Herbert Schildt", dummyBookDetailList));
//        dummyBookList.add(new Book("Thinking in Java", "Bruce Eckel", dummyBookDetailList));
//        dummyBookList.add(new Book("Java Concurrency in Practice", "Brian Goetz", dummyBookDetailList));
//        dummyBookList.add(new Book("Head First Design Patterns", "Elisabeth Freeman and Kathy Sierra", dummyBookDetailList));
//        dummyBookList.add(new Book("Think Java: How to think like a computer scientist", " Allen B. Downey", dummyBookDetailList));
//        dummyBookList.add(new Book("Core Java", "Cay S. Horstmann", dummyBookDetailList));
//
//        bookListLiveData.setValue(ResponseData.success(dummyBookList));
    }

    public void fetchDefaultBookList() {
        bookListLiveData.setValue(ResponseData.loading());
        bookRepository.getDefaultBook().enqueue(new Callback<List<Book>>() {
            @Override
            public void onResponse(Call<List<Book>> call, Response<List<Book>> response) {
                if (response.isSuccessful()) {
                    bookListLiveData.setValue(ResponseData.success(response.body()));
                } else {
                    bookListLiveData.setValue(ResponseData.error("Can not load book list!"));
                }
            }

            @Override
            public void onFailure(Call<List<Book>> call, Throwable t) {
                bookListLiveData.setValue(ResponseData.error(t.getMessage()));
            }
        });
    }
}
