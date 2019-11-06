import Flutter
import UIKit
import MessageUI
import FacebookShare
import TwitterKit

public class SwiftSocialSharingPlugin: NSObject, FlutterPlugin {
    
    private var activity: UIViewController? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "social_sharing", binaryMessenger: registrar.messenger())
        let instance = SwiftSocialSharingPlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        guard let args = call.arguments as? [String: Any],
            let message = args["msg"] as? String else {
                return
        }
        let url = args["url"] as? String
        switch call.method as String {
        case "facebook":
            let dialog = ShareDialog()
            let content = ShareLinkContent()
            if let contentUrl = url {
                content.contentURL = URL(string:contentUrl)!
            }
            content.quote = message
            dialog.shareContent = content
            guard dialog.canShow else {
                result("fb-error")
                return
            }
            dialog.show()
            result("fb-ok")
            
        case "twitter":
            if Twitter.sharedInstance().sessionStore.session()?.authToken  == nil {
                Twitter.sharedInstance().logIn(completion: { (session, error) in
                    if (session != nil) {
                        print("signed in as \(session!.userName)");
                    } else {
                        print("error: \(error!.localizedDescription)");
                    }
                })
            }
            
            let composer = TWTRComposer()
            composer.setText(message)
            if (url != nil) {
                let currentUrl = URL(string: url!)
                if(currentUrl != nil){
                    composer.setURL(URL(string:url!)!)
                }
            }
            
            guard let keyWindow = UIApplication.shared.keyWindow,
                let controller = keyWindow.rootViewController else {
                result("tw-eror")
                return
            }
            
            composer.show(from: controller) { (result) in
                if (result == .done) {
                    print("Successfully composed Tweet")
                } else {
                    print("Cancelled composing")
                }}
            result("twitter")
            break
        case "system":
            
            let email = "konszhog@gmail.com"
            let url = URL(string: "mailto://to\(email)")! as URL
            print(UIApplication.shared.canOpenURL(url))
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else {
                UIApplication.shared.openURL(url)
            }
            result("Mait to")
            break;
        default:
            result("not implemented")
        }
    }
}
