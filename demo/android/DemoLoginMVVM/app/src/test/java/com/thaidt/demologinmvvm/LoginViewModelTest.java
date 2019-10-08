package com.thaidt.demologinmvvm;

import android.app.Application;
import android.content.Context;
import android.provider.ContactsContract;

import androidx.arch.core.executor.testing.InstantTaskExecutorRule;
import androidx.lifecycle.Observer;

import com.thaidt.demologinmvvm.model.User;
import com.thaidt.demologinmvvm.model.UserDao;
import com.thaidt.demologinmvvm.model.UserRepository;
import com.thaidt.demologinmvvm.viewmodel.DataWrapper;
import com.thaidt.demologinmvvm.viewmodel.LoginViewModel;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TestRule;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.RuntimeEnvironment;
import org.robolectric.annotation.Config;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(RobolectricTestRunner.class)
@Config(application = Application.class)
public class LoginViewModelTest {
    @Rule
    public TestRule rule = new InstantTaskExecutorRule();

    private LoginViewModel loginVM;

    private UserRepository userRepo;

    @Mock
    private Observer<DataWrapper<User>> observer;
//    private Observer<DataWrapper<User>> observer = Mockito.mock(Observer.class);

    @Mock
    private UserDao userDao;
//    private UserDao userDao = Mockito.mock(UserDao.class);

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);

        Application appContext = RuntimeEnvironment.application;
        loginVM = new LoginViewModel(appContext);
        userRepo = new UserRepository(userDao);
        loginVM.getUserLiveData().observeForever(observer);
    }

    @Test
    public void testNull() {
//        when(userRepo.login("a", "a")).thenReturn(null);
        assertNotNull(loginVM.getUserLiveData());
        assertTrue(loginVM.getUserLiveData().hasObservers());
    }

    @Test
    public void login_error() {
        given(userRepo.login("a", "a")).willReturn(new User("a", "a"));

        loginVM.login();

        DataWrapper<User> expectResult = new DataWrapper<User>(DataWrapper.State.ERROR, "Error text");

        ArgumentCaptor<DataWrapper<User>> captor = ArgumentCaptor.forClass(DataWrapper.class);

        verify(observer,times(2)).onChanged(captor.capture());

        assertEquals(DataWrapper.State.ERROR, captor.getValue().getState());
    }
}
