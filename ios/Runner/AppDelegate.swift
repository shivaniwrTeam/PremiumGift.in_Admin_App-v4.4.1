/*
import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
 */


 import UIKit
 import Flutter
 import Firebase
 import flutter_downloader


 @UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate { //, MessagingDelegate
  override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     /*  GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions) */

     if(FirebaseApp.app() == nil){
         FirebaseApp.configure()
     }

     if #available(iOS 10.0, *) {
       // For iOS 10 display notification (sent via APNS)
       UNUserNotificationCenter.current().delegate = self

       let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
       UNUserNotificationCenter.current().requestAuthorization(
         options: authOptions,
         completionHandler: {_, _ in })
     } else {
       let settings: UIUserNotificationSettings =
       UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
       application.registerUserNotificationSettings(settings)
     }


     application.registerForRemoteNotifications()

//      Messaging.messaging().token { token, error in
//        if let error = error {
//          print("Error fetching FCM registration token: \(error)")
//        } else if let token = token {
//          print("FCM registration token: \(token)")
//  //        self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
//        }
//      }
      FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   }
 }
 private func registerPlugins(registry: FlutterPluginRegistry) {
     if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
     }
 }

