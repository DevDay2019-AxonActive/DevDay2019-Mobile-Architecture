package com.aavn.devday.booklibrary.data.repository;

import android.content.SharedPreferences;

import com.aavn.devday.booklibrary.data.model.User;
import com.aavn.devday.booklibrary.utils.Constants;

public class UserRepository {

    private SharedPreferences pref;

    public UserRepository(SharedPreferences pref) {
        this.pref = pref;
    }

    public User login(String usernameInput, String passwordInput) {
        if (pref == null) return null;
        String username = pref.getString(Constants.PREF_USER_NAME, "");
        String password = pref.getString(Constants.PREF_PASSWORD, "");
        if (password != null
                && username != null
                && username.equalsIgnoreCase(usernameInput)
                && password.equalsIgnoreCase(passwordInput)) {
            return new User(username, password);
        }
        return null;
    }

}
