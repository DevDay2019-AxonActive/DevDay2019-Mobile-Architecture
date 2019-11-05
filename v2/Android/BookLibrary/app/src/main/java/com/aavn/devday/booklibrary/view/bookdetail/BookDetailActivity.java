package com.aavn.devday.booklibrary.view.bookdetail;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.aavn.devday.booklibrary.R;
import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.aavn.devday.booklibrary.data.model.Rating;
import com.aavn.devday.booklibrary.data.model.ResponseData;
import com.aavn.devday.booklibrary.utils.Constants;
import com.aavn.devday.booklibrary.view.main.BookListAdapter;
import com.aavn.devday.booklibrary.viewmodel.BookDetailViewModel;
import com.bumptech.glide.Glide;

import java.util.List;

public class BookDetailActivity extends AppCompatActivity {

    private ProgressBar progressBar;
    private BookDetailViewModel bookDetailViewModel;
    private ImageView imageView;
    private TextView tvTitle;
    private TextView tvDescription;
    private TextView tvAuthor;
    private TextView ratingValue;
    private RecyclerView recyclerView;
    private CommentAdapter cmtAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_book_detail);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setDisplayShowHomeEnabled(true);

        bindView();
        bookDetailViewModel = ViewModelProviders.of(this).get(BookDetailViewModel.class);
        observeBookDetailData();
        if (getIntent().hasExtra(Constants.BOOK_ID)) {
            Integer bookId = getIntent().getIntExtra(Constants.BOOK_ID, -1);
            bookDetailViewModel.getBookDetailData(bookId);
        }
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return true;
    }

    private void bindView() {
        progressBar = findViewById(R.id.progress_bar);
        imageView = findViewById(R.id.iv_book_cover);
        tvTitle = findViewById(R.id.tv_item_book_title);
        tvDescription = findViewById(R.id.tv_item_book_brief_description);
        tvAuthor = findViewById(R.id.tv_item_book_author);
        ratingValue = findViewById(R.id.tv_item_book_author);
        recyclerView = findViewById(R.id.rv_comment);


        cmtAdapter = new CommentAdapter();
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setAdapter(cmtAdapter);
    }
    private void observeBookDetailData() {
        bookDetailViewModel.observeBookDetail().observe(this, new Observer<ResponseData<Book>>() {
            @Override
            public void onChanged(ResponseData<Book> response) {
                switch (response.getState()) {
                    case LOADING:
                        progressBar.setVisibility(View.VISIBLE);
                        break;
                    case SUCCESS:
                        progressBar.setVisibility(View.GONE);
                        tvTitle.setText(response.getData().getTitle());
                        tvAuthor.setText(response.getData().getAuthor());
                        if (response.getData().getDetails().size() > 0) {
                            ratingValue.setText("Rating: " + getRatingValue(response.getData().getDetails().get(0).getRatings()));
                            tvDescription.setText(response.getData().getDetails().get(0).getDescription());
                            if (response.getData().getDetails().get(0).getComments().size() > 0) {
                                cmtAdapter.setItems(response.getData().getDetails().get(0).getComments());
                                cmtAdapter.notifyDataSetChanged();
                            }
                            Glide.with(imageView)
                                    .load(response.getData().getDetails().get(0).getCoverUrl())
                                    .placeholder(R.drawable.book_cover_placeholder)
                                    .thumbnail(0.1f)
                                    .into(imageView);
                        }
                        break;
                    default:
                        progressBar.setVisibility(View.GONE);
                        break;
                }
            }
        });
    }

    private int getRatingValue(List<Rating> ratings) {
        int result = 0;
        for (Rating rating : ratings) {
            result+=rating.getValue();
        }
        return result/ratings.size();
    }
}
