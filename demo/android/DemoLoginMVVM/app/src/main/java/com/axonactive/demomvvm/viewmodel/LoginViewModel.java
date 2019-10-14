package com.axonactive.demomvvm.viewmodel;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;

import com.axonactive.demomvvm.data.model.ResponseData;
import com.axonactive.demomvvm.data.model.User;
import com.axonactive.demomvvm.data.repository.UserRepository;
import com.axonactive.demomvvm.utils.Constants;

public class LoginViewModel extends AndroidViewModel {
    private MutableLiveData<ResponseData<User>> loginLiveData;

    private UserRepository userRepository;

    public LoginViewModel(@NonNull Application application) {
        super(application);
        SharedPreferences pref = application.getApplicationContext().getSharedPreferences(Constants.PREFS_NAME, Context.MODE_PRIVATE);
        userRepository = new UserRepository(pref);
    }

    //For test
    public LoginViewModel(@NonNull Application application, UserRepository userRepo) {
        super(application);
        userRepository = userRepo;
    }

    public LiveData<ResponseData<User>> getUserLiveData() {
        if (loginLiveData == null) {
            loginLiveData = new MutableLiveData<>();
        }
        return loginLiveData;
    }

    public void login(String username, String password) {
        if (username == null || username.isEmpty()) {
            loginLiveData.setValue(new ResponseData<User>(ResponseData.State.ERROR, "email is empty"));
            return;
        }

        if (password == null || password.isEmpty()) {
            loginLiveData.setValue(new ResponseData<User>(ResponseData.State.ERROR, "password is empty"));
            return;
        }

        loginLiveData.setValue(new ResponseData<User>(ResponseData.State.LOADING));

        User result = userRepository.login(username, password);
        if (result != null) {
            loginLiveData.setValue(new ResponseData<User>(ResponseData.State.SUCCESS, result));
        } else {
            loginLiveData.setValue(new ResponseData<User>(ResponseData.State.ERROR, "wrong username or password"));
        }
    }

}
