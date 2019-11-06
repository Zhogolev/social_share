package com.zhogolev.social_sharing

import android.app.Activity
import android.content.Intent
import android.net.Uri
import com.facebook.share.model.ShareLinkContent
import com.facebook.share.widget.ShareDialog
import com.twitter.sdk.android.tweetcomposer.TweetComposer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.net.MalformedURLException
import java.net.URL

class SocialSharingPlugin(registrar: Registrar) : MethodCallHandler {

    private var activity: Activity = registrar.activity()

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "social_sharing")
            channel.setMethodCallHandler(SocialSharingPlugin(registrar))
        }
    }

    private fun shareSystem(result: Result, msg: String) {
        try {
            val textIntent = Intent("android.intent.action.SEND")
            textIntent.type = "text/plain"
            textIntent.putExtra("android.intent.extra.TEXT", msg)
            activity.startActivity(Intent.createChooser(textIntent, "Share to"))
            result.success("success")
        } catch (var7: Exception) {
            result.error("error", var7.toString(), "")
        }
    }

    private fun shareToTwitter(url: String?, msg: String, image: String?,result: Result) {
        try {
            val builder = TweetComposer.Builder(activity)
                    .text(msg)
            if (image.isNullOrEmpty() && url != null && url.isNotEmpty()) {
                builder.url(URL(url))
            }
            image?.let {
                builder.image(Uri.parse(image))
            }
            builder.show()
            result.success("success")
        } catch (e: MalformedURLException) {
            e.printStackTrace()
        }
    }

    private fun shareToFacebook(url: String, msg: String, result: Result) {
        val shareDialog = ShareDialog(activity)
        val content = ShareLinkContent.Builder()
                .setContentUrl(Uri.parse(url))
                .setQuote(msg)
                .build()
        if (ShareDialog.canShow(ShareLinkContent::class.java)) {
            shareDialog.show(content)
            result.success("success")
        }

    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val url: String = call.argument<String>("url") ?: ""
        val msg: String = call.argument<String>("msg") ?: ""
        val imageLocation: String = call.argument<String>("image") ?: ""
        when (call.method) {
            "facebook" -> {
                shareToFacebook(url, msg, result)
            }
            "twitter" -> {
                shareToTwitter(url, msg, imageLocation, result)
            }
            "system" -> {
                shareSystem(result, msg)
            }
            else -> result.notImplemented()
        }
    }
}
