package com.aavn.devday.booklibrary.data.model;

import com.google.gson.annotations.SerializedName;

public class User {
    @SerializedName("userId")
    private int userId;
    @SerializedName("username")
    private String username;
    @SerializedName("fullName")
    private String fullName;
    @SerializedName("email")
    private String email;

    public User(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
