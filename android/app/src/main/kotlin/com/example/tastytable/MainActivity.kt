package com.aakash.tastytable

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Check for deep link URL
        val intent = intent
        val data: Uri? = intent.data

        if (data != null) {
            val path = data.path // e.g., /home

            if (path != null && path.contains("/home")) {
                // Pass deep link data to Flutter
                intent.putExtra("deepLinkPath", "/home")
            }
        }
    }
}
