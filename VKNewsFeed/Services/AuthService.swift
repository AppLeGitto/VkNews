//
//  AuthService.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 19.05.2022.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "8170900"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthServiceDelegate?
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
                print("initialized")
            case .authorized:
                print("authorized")
            default:
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(viewController: controller)
        print("#function vkSdkShouldPresent")
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("#function vkSdkNeedCaptchaEnter")

    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        delegate?.authServiceSignIn()
        print("#function vkSdkAccessAuthorizationFinished")
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFail()
        print("#function vkSdkUserAuthorizationFailed")
    }
}