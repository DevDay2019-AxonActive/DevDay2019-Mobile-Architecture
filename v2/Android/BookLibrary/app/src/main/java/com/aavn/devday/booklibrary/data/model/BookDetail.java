package com.aavn.devday.booklibrary.data.model;

import com.google.gson.annotations.SerializedName;
import com.google.gson.annotations.Expose;

public class BookDetail {

//  "id": 26,
//          "name": "Waiting for Nick / Considering Kate (Stanislaski, Books 5 & 6) (Stanislaski Stories)",
//          "author": "Waiting for Nick / Considering Kate (Stanislaski, Books 5 & 6) (Stanislaski Stories)",
//          "serialNumber": "037328568X",
//          "details": [],
//          "subscribers": null

    @SerializedName("id")
    @Expose
    private Integer id;
    @SerializedName("name")
    @Expose
    private String name;
    @SerializedName("author")
    @Expose
    private String author;
    @SerializedName("serialNumber")
    @Expose
    private String serialNumber;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }
}
