package com.aavn.devday.booklibrary.viewmodel;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.aavn.devday.booklibrary.data.model.ResponseData;
import com.aavn.devday.booklibrary.data.repository.BookRepository;

import java.util.List;

import io.reactivex.SingleObserver;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class BookDetailViewModel extends ViewModel {
    private MutableLiveData<ResponseData<BookDetail>> bookDetail = new MutableLiveData<>();

    private BookRepository bookRepository;

    private CompositeDisposable compositeDisposable = new CompositeDisposable();

    public BookDetailViewModel() {
        bookRepository = new BookRepository();
    }

    //For test
    public BookDetailViewModel(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public LiveData<ResponseData<BookDetail>> getBookDetail() {
        return bookDetail;
    }

    public void getBookDetail(Integer bookId) {
        bookDetail.setValue(ResponseData.loading());

        bookRepository.getBookDetail(bookId)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new SingleObserver<BookDetail>() {
                    @Override
                    public void onSubscribe(Disposable d) {
                        compositeDisposable.add(d);
                    }

                    @Override
                    public void onSuccess(BookDetail book) {
                        bookDetail.setValue(ResponseData.success(book));
                    }

                    @Override
                    public void onError(Throwable e) {
                        bookDetail.setValue(ResponseData.error(e.getMessage()));
                    }
                });

    }

    @Override
    protected void onCleared() {
        super.onCleared();
        compositeDisposable.dispose();
    }
}
