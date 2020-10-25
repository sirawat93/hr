import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let METHODCHANNEL = "sample.test.platform/text"
    //let EVENTCHANNEL = "sample.test.platform/number"
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    /// ใน swift เราประกาศตัวแปร methodChannel ไว้ก่อนเลย จริงๆบน kotlin ก็ทำแบบเดียวกันได้
    let methodChannel = FlutterMethodChannel(name: METHODCHANNEL,
                                              binaryMessenger: controller.binaryMessenger)
    /// หลังจากประกาศ แล้วถึงมาเรียก .setMethodCallHandler
    methodChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
        switch call.method {
        case "sendtext":
            // เมื่อเรา invokeMethod("sendtext") จะรันด้านล่างนี้
            let argument: [String: String] = call.arguments as! [String: String]
            let returntext = self.getStringReturnToDart(text: argument["message"]!)
            // ปริ้น log ไปที่ syslog ของ Flutter
            NSLog("from iOS: send text back")
            // ส่งข้อความกลับไป Flutter
            result(returntext)
        default:
            // ถ้าเรา invokeMethod ที่ไม่ได้รองรับ
            result(FlutterMethodNotImplemented)
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getStringReturnToDart(text: String) -> String {
      return text + " <- from iOS"
    }
}