package com.aavn.devday.booklibrary.view.bookdetail;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.ProgressBar;

import com.aavn.devday.booklibrary.R;
import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.aavn.devday.booklibrary.data.model.ResponseData;
import com.aavn.devday.booklibrary.viewmodel.BookDetailViewModel;
import com.aavn.devday.booklibrary.viewmodel.BookListViewModel;
import com.bumptech.glide.Glide;

import java.util.List;

public class BookDetailActivity extends AppCompatActivity {

    private ProgressBar progressBar;
    private BookDetailViewModel bookDetailViewModel;
    private ImageView imageView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_book_detail);
        bindView();
        bookDetailViewModel = ViewModelProviders.of(this).get(BookDetailViewModel.class);
        observeBookListData();
    }

    private void bindView() {
        progressBar = findViewById(R.id.progress_bar);
    }
    private void observeBookListData() {
        bookDetailViewModel.getBookDetail().observe(this, new Observer<ResponseData<BookDetail>>() {
            @Override
            public void onChanged(ResponseData<BookDetail> response) {
                switch (response.getState()) {
                    case LOADING:
                        progressBar.setVisibility(View.VISIBLE);
                        break;
                    case SUCCESS:
                        progressBar.setVisibility(View.GONE);
                        Glide.with(imageView)
                                .load(response.getData().getCoverUrl())
                                .placeholder(R.drawable.book_cover_placeholder)
                                .thumbnail(0.1f)
                                .into(imageView);
                        break;
                    default:
                        progressBar.setVisibility(View.GONE);
                        break;
                }
            }
        });
    }
}
