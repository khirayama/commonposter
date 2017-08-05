package com.example.kotarohirayama.commonposter;

import android.app.Dialog;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.auth0.android.Auth0;
import com.auth0.android.authentication.AuthenticationException;
import com.auth0.android.provider.AuthCallback;
import com.auth0.android.provider.WebAuthProvider;
import com.auth0.android.result.Credentials;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {
    private TextView tokenView;
    private String token;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tokenView = (TextView) findViewById(R.id.token);

        Button loginButton = (Button) findViewById(R.id.loginButton);
        Button publicAPIButton = (Button) findViewById(R.id.publicAPIButton);
        Button privateAPIButton = (Button) findViewById(R.id.privateAPIButton);

        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                login();
            }
        });
        publicAPIButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl("http://172.16.153.103:3001/")
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                IPublicMessageService service = retrofit.create(IPublicMessageService.class);

                Call<Message> messageCall = service.publicAPI();
                messageCall.enqueue(new Callback<Message>() {
                    @Override
                    public void onResponse(Call<Message> call, Response<Message> response) {
                        Message message = response.body();
                        System.out.println("success");
                        System.out.println(message.message);
                    }

                    @Override
                    public void onFailure(Call<Message> call, Throwable t) {
                        System.out.println(t);
                    }
                });
            }
        });
        privateAPIButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl("http://172.16.153.103:3001/")
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                IPublicMessageService service = retrofit.create(IPublicMessageService.class);

                Call<Message> messageCall = service.privateAPI("Bearer " + token);
                messageCall.enqueue(new Callback<Message>() {
                    @Override
                    public void onResponse(Call<Message> call, Response<Message> response) {
                        Message message = response.body();
                        System.out.println(message.message);
                    }

                    @Override
                    public void onFailure(Call<Message> call, Throwable t) {
                        System.out.println(t);
                    }
                });
            }
        });
    }

    private void login() {
        tokenView.setText("Not logged in");

        Auth0 auth0 = new Auth0(this);
        auth0.setOIDCConformant(true);
        WebAuthProvider.init(auth0)
                .withScheme(getString(R.string.auth0_scheme))
                .start(MainActivity.this, new AuthCallback() {
                    @Override
                    public void onFailure(@NonNull final Dialog dialog) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                dialog.show();
                            }
                        });
                    }

                    @Override
                    public void onFailure(final AuthenticationException exception) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Toast.makeText(MainActivity.this, "Error: " + exception.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        });
                    }

                    @Override
                    public void onSuccess(@NonNull final Credentials credentials) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                tokenView.setText("Logged in: " + credentials.getAccessToken());
                                token = credentials.getIdToken();
                            }
                        });
                    }
                });
    }
}

