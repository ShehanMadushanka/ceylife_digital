package com.ceylincolife.ceylifeapp

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import android.view.WindowManager
import androidx.annotation.NonNull
import external.*
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import io.flutter.view.FlutterMain

class MainActivity : FlutterFragmentActivity(), PluginRegistry.PluginRegistrantCallback {
    private val CHANNEL = "ceylinco_method_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        FlutterMain.startInitialization(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (!registry!!.hasPlugin("io.flutter.plugins.firebasemessaging")) {
            FirebaseMessagingPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "c8fe82764f3a63f8eb5cd8c11a272b313ef113880c8eb3b8714004719eb958c3" -> {
                    result.success(VisionAXEOM.getMicroFabricationStructure(applicationContext))
                }
                "2672ef947486257c71881b970411546803f35a4ed09833edf55ab2e8968684c0" -> {
                    result.success(Luca.getSilicaNucleicAcidExtractionPHValue(applicationContext))
                }
                "cdec2bb0ae84adc926bac868fc193b34a8e40a0e2970c9cda11f6bf9124427ef" -> {
                    result.success(AelonFlux.isStaticFluxReleased(applicationContext))
                }
                "bcf8b716f48ac74e853995f0a59fbdfe7f261fa247784ba8fe19218a07ce9517" -> {
                    result.success(TerraNova.hasMaxQPassed())
                }
                "75182d4878251a71bd16f72114be3dc05f0b3d957545dafa905416f571b8303d" -> {
                    result.success(BioWPN.checkAvailability(applicationContext))
                }
                "a0404261b67a4debc2a32790ac94d132b3b6085e5da4b58129527dc8f371dcaf" -> {
                    directToUsbDebugging()
                }
            }
        }
    }

    fun directToUsbDebugging() {
        val intent = Intent(Settings.ACTION_APPLICATION_DEVELOPMENT_SETTINGS)
        startActivity(intent)
    }
}
