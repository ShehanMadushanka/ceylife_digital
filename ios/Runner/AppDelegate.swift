import UIKit
import Flutter
import GoogleMaps
import flutter_downloader

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDzYpKRAc6pvXuwmjhLRBIiF-eNMyDUGmI")
    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback { registry in
            if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
               FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
            }
    }
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    let channelName = "ceylinco_method_channel"
    let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController as! FlutterBinaryMessenger)
    
    methodChannel.setMethodCallHandler {(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if (call.method == "messedUp") {
            let messed = UIDevice.isAppContainUnAuthorizedApps() ||
                UIDevice.isAppCanEditSystemFiles() ||
                UIDevice.isAppCanOpenUnAuthorizedURL() ||
                UIDevice.isAppContainUnAuthorizedFiles() ||
                UIDevice.isSystemAPIAccessable()
            
            result(messed)
        }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
