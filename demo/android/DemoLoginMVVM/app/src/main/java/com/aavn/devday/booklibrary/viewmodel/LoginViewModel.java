package com.aavn.devday.booklibrary.viewmodel;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;

import com.aavn.devday.booklibrary.data.manager.UserManager;
import com.aavn.devday.booklibrary.data.model.ResponseData;
import com.aavn.devday.booklibrary.data.model.User;
import com.aavn.devday.booklibrary.data.repository.UserRepository;
import com.aavn.devday.booklibrary.utils.Constants;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class LoginViewModel extends AndroidViewModel {
    private MutableLiveData<ResponseData<User>> loginLiveData;

    private UserRepository userRepository;

    public LoginViewModel(@NonNull Application application) {
        super(application);
        SharedPreferences pref = application.getApplicationContext().getSharedPreferences(Constants.PREFS_NAME, Context.MODE_PRIVATE);
        userRepository = new UserRepository();
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

        userRepository.login(username, password).enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                loginLiveData.setValue(new ResponseData<User>(ResponseData.State.SUCCESS, response.body()));
                UserManager.getInstance().setUserInfo(response.body());
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {
                loginLiveData.setValue(new ResponseData<User>(ResponseData.State.ERROR, "wrong username or password"));
            }
        });
    }

}
