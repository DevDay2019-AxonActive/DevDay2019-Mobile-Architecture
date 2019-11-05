package com.aavn.devday.booklibrary.view.bookdetail;

import android.os.Build;
import android.text.Html;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.aavn.devday.booklibrary.R;
import com.aavn.devday.booklibrary.data.model.Book;
import com.aavn.devday.booklibrary.data.model.BookDetail;
import com.aavn.devday.booklibrary.data.model.Comment;
import com.aavn.devday.booklibrary.view.main.BookSelectListener;
import com.bumptech.glide.Glide;

import java.util.ArrayList;
import java.util.List;

public class CommentAdapter extends RecyclerView.Adapter<CommentAdapter.CommentViewHolder> {

    private List<Comment> items = new ArrayList<>();

    @NonNull
    @Override
    public CommentViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_comment, parent, false);
        return new CommentViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CommentViewHolder holder, int position) {
        Comment data = items.get(position);
        holder.bindData(data);
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    void setItems(List<Comment> data) {
        items = new ArrayList<>();
        items.addAll(data);
        notifyDataSetChanged();
    }

    static class CommentViewHolder extends RecyclerView.ViewHolder {
        TextView tvComment;
        TextView tvUser;
        LinearLayout lnChildCmt;

        CommentViewHolder(@NonNull View itemView) {
            super(itemView);
            tvComment = itemView.findViewById(R.id.tv_comment);
            tvUser = itemView.findViewById(R.id.tv_user_name);
            lnChildCmt = itemView.findViewById(R.id.ln_child_comment);
        }

        void bindData(Comment data) {
            tvComment.setText(data.getContent());
            tvUser.setText(data.getUser().getFullName());
        }
    }

}
