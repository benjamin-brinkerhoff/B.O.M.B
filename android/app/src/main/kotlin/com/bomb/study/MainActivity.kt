package com.bomb.study

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.bomb.study/dictionary"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openDeviceDictionary") {
                val word = call.argument<String>("word") ?: ""
                try {
                    val intent = Intent(Intent.ACTION_DEFINE).apply {
                        putExtra(Intent.EXTRA_TEXT, word)
                    }
                    if (intent.resolveActivity(packageManager) != null) {
                        startActivity(intent)
                        result.success(true)
                    } else {
                        val webIntent = Intent(Intent.ACTION_WEB_SEARCH).apply {
                            putExtra("query", "define $word")
                        }
                        startActivity(webIntent)
                        result.success(true)
                    }
                } catch (e: Exception) {
                    result.error("ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
