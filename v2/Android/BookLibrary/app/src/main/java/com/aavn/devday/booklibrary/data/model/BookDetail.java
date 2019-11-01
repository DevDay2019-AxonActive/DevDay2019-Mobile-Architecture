package com.aavn.devday.booklibrary.data.model;

import com.google.gson.annotations.SerializedName;
import java.util.List;
import com.google.gson.annotations.Expose;

public class BookDetail {

    @SerializedName("comments")
    @Expose
    private List<Comment> comments = null;
    @SerializedName("coverUrl")
    @Expose
    private String coverUrl;
    @SerializedName("description")
    @Expose
    private String description;
    @SerializedName("id")
    @Expose
    private Integer id;
    @SerializedName("ratings")
    @Expose
    private List<Rating> ratings = null;
    @SerializedName("source")
    @Expose
    private String source;

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public List<Rating> getRatings() {
        return ratings;
    }

    public void setRatings(List<Rating> ratings) {
        this.ratings = ratings;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
}
