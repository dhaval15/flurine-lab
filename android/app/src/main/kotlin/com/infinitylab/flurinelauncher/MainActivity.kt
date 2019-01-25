package com.infinitylab.flurinelauncher

import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.AdaptiveIconDrawable
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.LayerDrawable
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.ByteArrayOutputStream
import java.util.*




class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, "com.flurine.apps_assist")
                .setMethodCallHandler(AppsAssistPlugin(this))
        EventChannel(flutterView,"com.flurine.apps_stream")
                .setStreamHandler(AppsStream(this))
    }
}

class AppsStream(private val context: Context):Thread(),EventChannel.StreamHandler {

    private var sink:EventChannel.EventSink?=null

    override fun run() {
        super.run()
        getAllApps(sink!!)
        sink?.endOfStream()
    }

    override fun onListen(p0: Any?, p1: EventChannel.EventSink) {
        sink=p1
        start()
    }

    override fun onCancel(p0: Any?) {
    }

    private fun getAllApps(sink:EventChannel.EventSink) {

        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)

        val manager = context.packageManager
        val resList = manager.queryIntentActivities(intent, 0)
        Collections.sort(resList, ResolveInfo.DisplayNameComparator(manager))

        for (resInfo in resList) {
            try {
                val app = manager.getApplicationInfo(
                        resInfo.activityInfo.packageName, PackageManager.GET_META_DATA)
                if (manager.getLaunchIntentForPackage(app.packageName) != null) {

                    val i = app.loadIcon(manager)

                    val icon = if (i is AdaptiveIconDrawable) {
                        val layerDrawable = LayerDrawable(arrayOf(i.background, i.foreground))
                        val width = layerDrawable.intrinsicWidth
                        val height = layerDrawable.intrinsicHeight
                        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
                        val canvas = Canvas(bitmap)

                        layerDrawable.setBounds(0, 0, width, height)
                        layerDrawable.draw(canvas)
                        bitmap
                    } else {
                        (i as BitmapDrawable).bitmap
                    }
                    val iconData = AppsAssistPlugin.convertToBytes(icon,
                            Bitmap.CompressFormat.PNG, 100)

                    val current = HashMap<String, Any>()
                    current["label"] = app.loadLabel(manager).toString()
                    current["icon"] = iconData
                    current["package"] = app.packageName
                    sink.success(current)
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }

        }

    }
}
class AppsAssistPlugin(private val context: Context) : MethodChannel.MethodCallHandler {

    private var wallpaperData: ByteArray? = null

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when {
            methodCall.method == "getAllApps" -> getAllApps(result)
            methodCall.method == "launchApp" -> launchApp(methodCall.argument<String>("packageName")!!)
            methodCall.method == "getWallpaper" -> getWallpaper(result)
        }
    }

    private fun getWallpaper(result: MethodChannel.Result) {
        if (wallpaperData != null) {
            result.success(wallpaperData)
            return
        }

        val wallpaperManager = WallpaperManager.getInstance(context)
        val wallpaperDrawable = wallpaperManager.drawable
        if (wallpaperDrawable is BitmapDrawable) {
            wallpaperData = convertToBytes(wallpaperDrawable.bitmap,
                    Bitmap.CompressFormat.JPEG, 100)
            result.success(wallpaperData)
        }
    }

    private fun launchApp(packageName: String) {
        val i = context.packageManager.getLaunchIntentForPackage(packageName)
        if (i != null)
            context.startActivity(i)
    }

    private fun getAllApps(result: MethodChannel.Result) {

        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)

        val manager = context.packageManager
        val resList = manager.queryIntentActivities(intent, 0)

        val output = ArrayList<Map<String, Any>>()

        for (resInfo in resList) {
            try {
                val app = manager.getApplicationInfo(
                        resInfo.activityInfo.packageName, PackageManager.GET_META_DATA)
                if (manager.getLaunchIntentForPackage(app.packageName) != null) {

                    val i = app.loadIcon(manager)

                    val icon=if(i is AdaptiveIconDrawable){
                        val layerDrawable=LayerDrawable(arrayOf(i.background,i.foreground))
                        val width = layerDrawable.intrinsicWidth
                        val height = layerDrawable.intrinsicHeight
                        val bitmap=Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
                        val canvas = Canvas(bitmap)

                        layerDrawable.setBounds(0, 0,width,height)
                        layerDrawable.draw(canvas)
                        bitmap
                    }
                    else{
                        (i as BitmapDrawable).bitmap
                    }
                    val iconData = convertToBytes(icon,
                            Bitmap.CompressFormat.PNG, 100)

                    val current = HashMap<String, Any>()
                    current["label"] = app.loadLabel(manager).toString()
                    current["icon"] = iconData
                    current["package"] = app.packageName
                    output.add(current)
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }

        }

        result.success(output)
    }

    companion object {

        fun convertToBytes(image: Bitmap, compressFormat: Bitmap.CompressFormat, quality: Int): ByteArray {
            val byteArrayOS = ByteArrayOutputStream()
            image.compress(compressFormat, quality, byteArrayOS)
            return byteArrayOS.toByteArray()
        }
    }
}

