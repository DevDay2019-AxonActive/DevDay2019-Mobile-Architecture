package com.aavn.devday.booklibrary.data.model;

import com.google.gson.annotations.SerializedName;
import com.google.gson.annotations.Expose;

import java.util.List;

public class BookDetail {

    @SerializedName("id")
    @Expose
    private Integer id;

    @SerializedName("source")
    @Expose
    private String source;

    @SerializedName("description")
    @Expose
    private String description;

    @SerializedName("coverUrl")
    @Expose
    private String coverUrl;

    @SerializedName("comments")
    @Expose
    private List<Comment> comments;

    @SerializedName("ratings")
    @Expose
    private List<Rating> ratings;

    @SerializedName("tags")
    @Expose
    private List<Tag> tags;


    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public List<Rating> getRatings() {
        return ratings;
    }

    public void setRatings(List<Rating> ratings) {
        this.ratings = ratings;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
