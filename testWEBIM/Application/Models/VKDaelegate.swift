import SwiftyVK

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

final class VKDelegate: SwiftyVKDelegate {
    
    let appId = "XXXXXXXXX"
    let scopes: Scopes = [.friends,.wall]
    
    // .market, .photos, .audio, .video, .docs, .messages, .offline, .email
    
    init() {
        VK.setUp(appId: appId, delegate: self)
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        #if os(macOS)
        if let contentController = NSApplication.shared.keyWindow?.contentViewController {
            contentController.presentViewControllerAsSheet(viewController)
        }
        #elseif os(iOS)
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            rootController.present(viewController, animated: true)
        }
        #endif
    }
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
    }
    
    
}
