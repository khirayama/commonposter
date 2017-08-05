package com.example.kotarohirayama.commonposter;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

public interface IPublicMessageService {
    @GET("/public")
    Call<Message> publicAPI();

    @GET("/private")
    Call<Message> privateAPI(@Header("Authorization") String token);
}
