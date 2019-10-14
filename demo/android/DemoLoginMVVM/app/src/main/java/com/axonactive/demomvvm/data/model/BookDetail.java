package com.axonactive.demomvvm.data.model;

import com.google.gson.annotations.SerializedName;

public class BookDetail {
    @SerializedName("description")
    private String description;

    public BookDetail(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
