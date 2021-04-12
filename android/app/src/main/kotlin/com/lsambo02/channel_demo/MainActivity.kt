package com.lsambo02.channel_demo

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {


    private val channelName = "com.lsambo02.channel_demo/hello"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler {
            call, result ->
            if (call.method == "hello") {
                Log.d("flutter_msg", "Flutter says Hello")
            }else if (call.method == "convo"){
                
                result.success( "Hey, wassup!")

            }
        }
    }

}
