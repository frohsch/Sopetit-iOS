//
//  AppDelegate.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/28.
//

import UIKit

import KakaoSDKCommon
import AuthenticationServices
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String
        
        KakaoSDK.initSDK(appKey: apiKey!)
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: UserManager.shared.appleUserIdentifier ?? "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("authorized")
            case .revoked:
                print("revoked")
                UserManager.shared.clearAll()
            default:
                print("notFound")
            }
        }
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 13.0, *) {
                let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: UserManager.shared.appleUserIdentifier ?? "") { (credentialState, error) in
                    switch credentialState {
                    case .authorized:
                        print("authorized")
                    case .revoked:
                        print("revoked")
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let keyWindow = windowScene.windows.first else {
                            return
                        }
                        UserManager.shared.clearAll()
                        let nav = LoginViewController()
                        keyWindow.rootViewController = UINavigationController(rootViewController: nav)
                    default:
                        print("notFound")
                    }
                }
        }
    }
}
