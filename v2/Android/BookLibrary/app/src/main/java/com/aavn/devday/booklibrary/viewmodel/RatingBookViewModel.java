package com.aavn.devday.booklibrary.viewmodel;

import android.util.Log;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.ResponseData;
import com.aavn.devday.booklibrary.data.repository.BookRepository;

import java.util.List;

import io.reactivex.SingleObserver;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.disposables.Disposable;
import io.reactivex.schedulers.Schedulers;

public class RatingBookViewModel extends ViewModel {
    private MutableLiveData<ResponseData<Boolean>> ratingResult = new MutableLiveData<>();

    private BookRepository bookRepository;

    private CompositeDisposable compositeDisposable = new CompositeDisposable();

    public RatingBookViewModel() {
        bookRepository = new BookRepository();
    }

    //For test
    public RatingBookViewModel(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public LiveData<ResponseData<Boolean>> getRatingResult() {
        return ratingResult;
    }

    public void performRateBook(int userId, int bookId, float point) {
        bookRepository.rateBook(userId, bookId, point)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new SingleObserver<Boolean>() {
                    @Override
                    public void onSubscribe(Disposable d) {
                        compositeDisposable.add(d);
                    }

                    @Override
                    public void onSuccess(Boolean result) {
                        Log.d("Rating", result ? "true" : "false");
                    }

                    @Override
                    public void onError(Throwable e) {
                        Log.e("Rating", e.getMessage(), e);
                    }
                });
    }

    @Override
    protected void onCleared() {
        super.onCleared();
        compositeDisposable.dispose();
    }
}
