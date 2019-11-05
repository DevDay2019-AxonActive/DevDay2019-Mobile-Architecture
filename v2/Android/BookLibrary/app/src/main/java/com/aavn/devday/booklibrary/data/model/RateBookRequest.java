package com.aavn.devday.booklibrary.data.model;

import com.google.gson.annotations.SerializedName;

public class RateBookRequest {
    @SerializedName("point")
    private float point;

    public RateBookRequest(float point) {
        this.point = point;
    }
}
