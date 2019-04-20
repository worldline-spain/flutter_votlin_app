package com.worldline.fluttervotlinapp;

import android.os.Bundle;

import com.worldline.fluttervotlinapp.data.JsonLoader;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.worldline.fluttervotlinapp/fluttervotlinapp";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                switch (methodCall.method) {
                    case "getTalks":
                        getTalks(result);
                        break;
                    default:
                        result.notImplemented();
                }
            }
        });
    }

    private void getTalks(MethodChannel.Result result) {
        String jsonString = new JsonLoader().loadJson(getApplicationContext(), R.raw.schedule);
        result.success(jsonString);
    }
}
