package com.axonactive.demomvvm;

import android.app.Application;
import android.content.SharedPreferences;

import androidx.arch.core.executor.testing.InstantTaskExecutorRule;
import androidx.lifecycle.Observer;

import com.axonactive.demomvvm.data.model.User;
import com.axonactive.demomvvm.data.repository.UserRepository;
import com.axonactive.demomvvm.utils.Constants;
import com.axonactive.demomvvm.data.model.ResponseData;
import com.axonactive.demomvvm.viewmodel.LoginViewModel;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TestRule;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.RuntimeEnvironment;
import org.robolectric.annotation.Config;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

@RunWith(RobolectricTestRunner.class)
@Config(application = Application.class)
public class LoginViewModelTest {
//    @Rule
//    public TestRule rule = new InstantTaskExecutorRule();
//
//    private LoginViewModel mockLoginVM;
//
//    @Mock
//    private Observer<ResponseData<User>> mockObserver;
//
//    @Mock
//    private SharedPreferences mockPref;
//
//    @Before
//    public void setup() {
//        MockitoAnnotations.initMocks(this);
//        Application appContext = RuntimeEnvironment.application;
//        UserRepository mockUserRepo = new UserRepository(mockPref);
//
//        mockLoginVM = new LoginViewModel(appContext, mockUserRepo);
//        mockLoginVM.getUserLiveData().observeForever(mockObserver);
//
//        given(mockPref.getString(Constants.PREF_USER_NAME, "")).willReturn("aaa@aaa.com");
//        given(mockPref.getString(Constants.PREF_PASSWORD, "")).willReturn("111111");
//    }
//
//    @Test
//    public void test_liveData_notNull() {
//        assertNotNull(mockLoginVM.getUserLiveData());
//        assertTrue(mockLoginVM.getUserLiveData().hasObservers());
//    }
//
//    @Test
//    public void login_success() {
//        mockLoginVM.usernameInput.setValue("aaa@aaa.com");
//        mockLoginVM.passwordInput.setValue("111111");
//
//        mockLoginVM.login();
//
//        ArgumentCaptor<ResponseData<User>> captor = ArgumentCaptor.forClass(ResponseData.class);
//
//        verify(mockObserver,times(2)).onChanged(captor.capture());
//
//        assertEquals(ResponseData.State.LOADING, captor.getAllValues().get(0).getState());
//        assertEquals(ResponseData.State.SUCCESS, captor.getAllValues().get(1).getState());
//        assertEquals("aaa@aaa.com", captor.getAllValues().get(1).getData().getUsername());
//    }
//
//    @Test
//    public void login_username_blank() {
//        mockLoginVM.usernameInput.setValue("");
//        mockLoginVM.passwordInput.setValue("111111");
//
//        mockLoginVM.login();
//
//        ArgumentCaptor<ResponseData<User>> captor = ArgumentCaptor.forClass(ResponseData.class);
//
//        verify(mockObserver,times(1)).onChanged(captor.capture());
//
//        assertEquals(ResponseData.State.ERROR, captor.getValue().getState());
//        assertEquals("email is empty", captor.getValue().getMessage());
//    }
//
//    @Test
//    public void login_password_blank() {
//        mockLoginVM.usernameInput.setValue("aaa@aaa.com");
//        mockLoginVM.passwordInput.setValue("");
//
//        mockLoginVM.login();
//
//        ArgumentCaptor<ResponseData<User>> captor = ArgumentCaptor.forClass(ResponseData.class);
//
//        verify(mockObserver,times(1)).onChanged(captor.capture());
//
//        assertEquals(ResponseData.State.ERROR, captor.getValue().getState());
//        assertEquals("password is empty", captor.getValue().getMessage());
//    }
}
