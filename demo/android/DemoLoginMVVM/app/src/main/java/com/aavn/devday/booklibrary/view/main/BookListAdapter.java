package com.aavn.devday.booklibrary.view.main;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.aavn.devday.booklibrary.R;
import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.bumptech.glide.Glide;

import java.util.ArrayList;
import java.util.List;

public class BookListAdapter extends RecyclerView.Adapter<BookListAdapter.BookViewHolder> {

    private List<Book> items = new ArrayList<>();

    @NonNull
    @Override
    public BookViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_book, parent, false);
        return new BookViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull BookViewHolder holder, int position) {
        Book data = items.get(position);
        holder.bindData(data);
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    void setItems(List<Book> data) {
        items = new ArrayList<>();
        items.addAll(data);
        notifyDataSetChanged();
    }

    static class BookViewHolder extends RecyclerView.ViewHolder {

        BookViewHolder(@NonNull View itemView) {
            super(itemView);
        }

        void bindData(Book data) {
            TextView titleTv = itemView.findViewById(R.id.tv_item_book_title);
            TextView briefDesTv = itemView.findViewById(R.id.tv_item_book_brief_description);
            TextView authorTv = itemView.findViewById(R.id.tv_item_book_author);
            ImageView coverIv = itemView.findViewById(R.id.iv_book_cover);

            titleTv.setText(data.getTitle());
            authorTv.setText(data.getAuthor());
            if (data.getDetails() != null && !data.getDetails().isEmpty()) {
                BookDetail bookDetail = data.getDetails().get(0);
                briefDesTv.setText(bookDetail.getDescription());
                Glide.with(coverIv)
                        .load(bookDetail.getCoverUrl())
                        .placeholder(R.drawable.book_cover_placeholder)
                        .thumbnail(0.1f)
                        .into(coverIv);
            }
        }
    }

}