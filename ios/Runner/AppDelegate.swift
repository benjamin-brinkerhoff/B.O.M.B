import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let dictionaryChannel = FlutterMethodChannel(name: "com.bomb.study/dictionary", binaryMessenger: controller.binaryMessenger)

    dictionaryChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "openDeviceDictionary" {
        guard let args = call.arguments as? [String: Any],
              let word = args["word"] as? String else {
          result(FlutterError(code: "INVALID_ARGS", message: "Word required", details: nil))
          return
        }

        DispatchQueue.main.async {
          let refVC = UIReferenceLibraryViewController(term: word)
          controller.present(refVC, animated: true, completion: nil)
          result(true)
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
