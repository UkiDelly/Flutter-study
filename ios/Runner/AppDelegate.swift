import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let versionChannel = FlutterMethodChannel(name: "com.example.flutter_study", binaryMessenger: controller.binaryMessenger)
      
      versionChannel.setMethodCallHandler({
          [weak self](call: FlutterMethodCall, result: FlutterResult)-> Void in guard call.method == "getPlatformVersion" else {
              result(FlutterMethodNotImplemented)
              return
          }
          self?.getPlatformVersion(result: result)
          
      })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getPlatformVersion(result: FlutterResult){
        let device = UIDevice.current
        result(device.systemVersion)
    }
  
}
