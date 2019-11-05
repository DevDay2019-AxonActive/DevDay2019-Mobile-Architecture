package com.aavn.devday.booklibrary.view.bookdetail;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.aavn.devday.booklibrary.R;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.aavn.devday.booklibrary.data.model.ResponseData;
import com.aavn.devday.booklibrary.utils.Constants;
import com.aavn.devday.booklibrary.viewmodel.BookDetailViewModel;
import com.bumptech.glide.Glide;

public class BookDetailActivity extends AppCompatActivity {

    private ProgressBar progressBar;
    private BookDetailViewModel bookDetailViewModel;
    private ImageView imageView;
    private TextView tvTitle;
    private TextView tvDescription;
    private TextView tvAuthor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_book_detail);
        bindView();
        bookDetailViewModel = ViewModelProviders.of(this).get(BookDetailViewModel.class);
        observeBookDetailData();
        if (getIntent().hasExtra(Constants.BOOK_ID)) {
            Integer bookId = getIntent().getIntExtra(Constants.BOOK_ID, -1);
            bookDetailViewModel.getBookDetailData(bookId);
        }
    }

    private void bindView() {
        progressBar = findViewById(R.id.progress_bar);
        imageView = findViewById(R.id.iv_book_cover);
        tvTitle = findViewById(R.id.tv_item_book_title);
        tvDescription = findViewById(R.id.tv_item_book_brief_description);
        tvAuthor = findViewById(R.id.tv_item_book_author);
    }
    private void observeBookDetailData() {
        bookDetailViewModel.observeBookDetail().observe(this, new Observer<ResponseData<BookDetail>>() {
            @Override
            public void onChanged(ResponseData<BookDetail> response) {
                switch (response.getState()) {
                    case LOADING:
                        progressBar.setVisibility(View.VISIBLE);
                        break;
                    case SUCCESS:
                        progressBar.setVisibility(View.GONE);
                        tvTitle.setText(response.getData().getName());
                        tvDescription.setText(response.getData().getSerialNumber());
                        tvAuthor.setText(response.getData().getAuthor());
//                        Glide.with(imageView)
//                                .load(response.getData().getCoverUrl())
//                                .placeholder(R.drawable.book_cover_placeholder)
//                                .thumbnail(0.1f)
//                                .into(imageView);
                        break;
                    default:
                        progressBar.setVisibility(View.GONE);
                        break;
                }
            }
        });
    }
}
