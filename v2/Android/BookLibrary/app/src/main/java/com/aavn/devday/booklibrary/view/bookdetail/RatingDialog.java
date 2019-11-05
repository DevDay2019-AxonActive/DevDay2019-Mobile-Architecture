package com.aavn.devday.booklibrary.view.bookdetail;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.PorterDuff;
import android.graphics.drawable.LayerDrawable;
import android.net.Uri;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.RatingBar;
import android.widget.TextView;

import androidx.appcompat.app.AlertDialog;

import com.aavn.devday.booklibrary.R;

public class RatingDialog implements DialogInterface.OnClickListener {
    private final static String DEFAULT_TITLE = "Rate this book";
    private final static String DEFAULT_TEXT = "How much do you love this book?";
    private final static String DEFAULT_POSITIVE = "Ok";
    private final static String DEFAULT_NEGATIVE = "Cancel";
    private static final String TAG = RatingDialog.class.getSimpleName();
    private final Context context;
    private TextView contentTextView;
    private RatingBar ratingBar;
    private String title = null;
    private String rateText = null;
    private AlertDialog alertDialog;
    private View dialogView;
    private int starColor;
    private String positiveButtonText;
    private String negativeButtonText;
    private RatingDialogListener actionListener;

    public RatingDialog(Context context) {
        this.context = context;;
    }

    private void build() {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        LayoutInflater inflater = LayoutInflater.from(context);
        dialogView = inflater.inflate(R.layout.rating_dialog, null);
        String titleToAdd = (title == null) ? DEFAULT_TITLE : title;
        String textToAdd = (rateText == null) ? DEFAULT_TEXT : rateText;
        contentTextView = dialogView.findViewById(R.id.tv_rating_title);
        contentTextView.setText(textToAdd);
        ratingBar = dialogView.findViewById(R.id.rating_bar);
        ratingBar.setOnRatingBarChangeListener(new RatingBar.OnRatingBarChangeListener() {
            @Override
            public void onRatingChanged(RatingBar ratingBar, float v, boolean b) {
                Log.d(TAG, "Rating changed : " + v);
            }
        });

        if (starColor != -1) {
            LayerDrawable stars = (LayerDrawable) ratingBar.getProgressDrawable();
            stars.getDrawable(1).setColorFilter(starColor, PorterDuff.Mode.SRC_ATOP);
            stars.getDrawable(2).setColorFilter(starColor, PorterDuff.Mode.SRC_ATOP);
        }

        alertDialog = builder.setTitle(titleToAdd)
                .setView(dialogView)
                .setNegativeButton((negativeButtonText == null) ? DEFAULT_NEGATIVE : negativeButtonText, this)
                .setPositiveButton((positiveButtonText == null) ? DEFAULT_POSITIVE : positiveButtonText, this)
                .create();
    }

    public void show() {
        build();
        alertDialog.show();
    }

    @Override
    public void onClick(DialogInterface dialogInterface, int i) {
        if (i == DialogInterface.BUTTON_POSITIVE) {
            if (actionListener != null)
                actionListener.onSubmit(ratingBar.getRating());
        } else if (i == DialogInterface.BUTTON_NEGATIVE) {
            if (actionListener != null)
                actionListener.onCancel();
        }
        alertDialog.hide();
    }

    public RatingDialog setTitle(String title) {
        this.title = title;
        return this;

    }

    public RatingDialog setRateText(String rateText) {
        this.rateText = rateText;
        return this;
    }

    public RatingDialog setStarColor(int color) {
        starColor = color;
        return this;
    }

    public RatingDialog setPositiveButtonText(String positiveButtonText) {
        this.positiveButtonText = positiveButtonText;
        return this;
    }

    public RatingDialog setNegativeButtonText(String negativeButtonText) {
        this.negativeButtonText = negativeButtonText;
        return this;
    }

    public RatingDialog setActionListener(RatingDialogListener listener) {
        this.actionListener = listener;
        return this;
    }

    public interface RatingDialogListener {
        void onSubmit(float point);

        void onCancel();
    }
}
