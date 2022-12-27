package com.example.flutter_study


import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            "com.example.flutter_study"
        ).setMethodCallHandler{ call, result -> if (call.method == "getPlatformVersion"){
            val version = android.os.Build.VERSION.RELEASE
            result.success(version)
        } else{result.notImplemented()} }

    }
//
//    companion object {
//        const val CHANNEL = 'com.example.flutter_study'
//    }
//
//    override fun onCreate(savedInstanceState: Bundle?){
//        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith...
//
//        MethodChannel(flutterView, CHANNEL).setMethodVallHandler{
//            methodCall, result => if(methodCall.method == 'getPlatformVersion'){
//                result.success(android.os.Bundle.VERSION.RELEASE)
//        } else {
//            result.notImplemented()
//        }
//        }
//    }
}
