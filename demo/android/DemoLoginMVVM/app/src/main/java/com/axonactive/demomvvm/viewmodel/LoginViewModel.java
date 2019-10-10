package com.axonactive.demomvvm.viewmodel;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;

import com.axonactive.demomvvm.model.User;
import com.axonactive.demomvvm.model.UserRepository;
import com.axonactive.demomvvm.utils.Constants;

public class LoginViewModel extends AndroidViewModel {
    public MutableLiveData<String> usernameInput = new MutableLiveData<>();
    public MutableLiveData<String> passwordInput = new MutableLiveData<>();

    private MutableLiveData<DataWrapper<User>> loginLiveData;

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

    public LiveData<DataWrapper<User>> getUserLiveData() {
        if (loginLiveData == null) {
            loginLiveData = new MutableLiveData<>();
        }
        return loginLiveData;
    }

    public void login() {
        String email = usernameInput.getValue();
        String password = passwordInput.getValue();

        if (email == null || email.isEmpty()) {
            loginLiveData.setValue(new DataWrapper<User>(DataWrapper.State.ERROR, "email is empty"));
            return;
        }

        if (password == null || password.isEmpty()) {
            loginLiveData.setValue(new DataWrapper<User>(DataWrapper.State.ERROR, "password is empty"));
            return;
        }

        loginLiveData.setValue(new DataWrapper<User>(DataWrapper.State.LOADING));

        User result = userRepository.login(email, password);
        if (result != null) {
            loginLiveData.setValue(new DataWrapper<User>(DataWrapper.State.SUCCESS, result));
        } else {
            loginLiveData.setValue(new DataWrapper<User>(DataWrapper.State.ERROR, "wrong username or password"));
        }
    }

}
