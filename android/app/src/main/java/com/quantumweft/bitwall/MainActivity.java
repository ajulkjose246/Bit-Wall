package com.quantumweft.bitwall;

import android.app.WallpaperManager;
import android.content.Context;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.flutter.epic/epic";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
                String data = call.arguments();
                String[] str = data.split(" ");

                if (call.method.equals("setWall")) {
                    File imgFile = new File(this.getApplicationContext().getCacheDir(), str[0]);

                    new Thread(() -> {
                        try {
                            Uri imageUri = Uri.fromFile(imgFile);
                            WallpaperManager wallpaperManager = WallpaperManager.getInstance(this);
                            InputStream inputStream = new FileInputStream(imgFile);

                            if (str[1].equals("home")) {
                                wallpaperManager.setStream(inputStream, null, true, WallpaperManager.FLAG_SYSTEM);
                            } else if (str[1].equals("lock")) {
                                wallpaperManager.setStream(inputStream, null, true, WallpaperManager.FLAG_LOCK);
                            } else if (str[1].equals("both")) {
                                wallpaperManager.setStream(inputStream);
                            }

                            inputStream.close();
                            runOnUiThread(() -> result.success("success"));
                        } catch (IOException e) {
                            runOnUiThread(() -> result.error("IOException", e.getMessage(), null));
                        }
                    }).start();
                }
            });
    }
}
