package com.axonactive.demomvvm.view.main;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.axonactive.demomvvm.R;
import com.axonactive.demomvvm.data.model.Book;
import com.axonactive.demomvvm.data.model.ResponseData;
import com.axonactive.demomvvm.viewmodel.BookListViewModel;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    private BookListViewModel bookListViewModel;
    private BookListAdapter bookListAdapter;
    private EditText edtBookKeyword;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        bookListViewModel = ViewModelProviders.of(this).get(BookListViewModel.class);
        observeBookListData();

        RecyclerView bookListRv = findViewById(R.id.rv_book_list);

        bookListAdapter = new BookListAdapter();
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        bookListRv.setLayoutManager(layoutManager);
        bookListRv.setAdapter(bookListAdapter);

        edtBookKeyword = findViewById(R.id.edt_search_book);
        edtBookKeyword.clearFocus();

        edtBookKeyword.setOnEditorActionListener(new EditText.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int actionId, KeyEvent keyEvent) {
                if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                    bookListViewModel.searchBook(textView.getText().toString());
                    InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
                    imm.hideSoftInputFromWindow(edtBookKeyword.getWindowToken(), 0);
                    return true;
                }
                return false;
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_favorite) {
            Toast.makeText(this, "Clicked Favorite", Toast.LENGTH_SHORT).show();
        }
        return super.onOptionsItemSelected(item);
    }

    private void observeBookListData() {

        bookListViewModel.getBookListLiveData().observe(this, new Observer<ResponseData<List<Book>>>() {
            View loadingView = findViewById(R.id.view_loading);

            @Override
            public void onChanged(ResponseData<List<Book>> response) {
                switch (response.getState()) {
                    case LOADING:
                        loadingView.setVisibility(View.VISIBLE);
                        break;
                    case SUCCESS:
                        loadingView.setVisibility(View.GONE);
                        bookListAdapter.setItems(response.getData());
                        break;
                    default:
                        loadingView.setVisibility(View.GONE);
                        break;
                }
            }
        });
    }
}
