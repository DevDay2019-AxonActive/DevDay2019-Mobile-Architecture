package com.axonactive.demomvvm.view.main;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.axonactive.demomvvm.R;
import com.axonactive.demomvvm.data.model.Book;

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

    public void setItems(List<Book> data) {
        items = new ArrayList<>();
        items.addAll(data);
        notifyDataSetChanged();
    }

    static class BookViewHolder extends RecyclerView.ViewHolder {

        public BookViewHolder(@NonNull View itemView) {
            super(itemView);
        }

        public void bindData(Book data) {
            TextView titleTv = itemView.findViewById(R.id.tv_item_book_title);
            TextView briefDesTv = itemView.findViewById(R.id.tv_item_book_brief_description);
            TextView authorTv = itemView.findViewById(R.id.tv_item_book_author);

            titleTv.setText(data.getTitle());
            briefDesTv.setText(data.getDetails().get(0).getDescription());
            authorTv.setText(data.getAuthor());
        }
    }
}
