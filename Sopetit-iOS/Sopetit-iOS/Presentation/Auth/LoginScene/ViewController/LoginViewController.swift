//
//  LoginViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/7/24.
//

import UIKit

import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = LoginViewModel()
    
    // MARK: - UI Components
    
    private let loginView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
    
    // MARK: - Setup
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setDelegate() {
        loginView.loginDelegate = self
    }
}

// MARK: - Extensions

extension LoginViewController: LoginDelegate {
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if error != nil {
                    self.showKakaoLoginFailMessage()
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.viewModel.postLoginAPI(socialAccessToken: accessToken, socialType: "KAKAO") { result in
                            switch result {
                            case .success:
                                self.viewModel.checkKakaoUser()
                                if self.viewModel.kakaoEntity!.isMemberDollExist {
                                    UserManager.shared.hasPostMember()
                                    let nav = TabBarController()
                                    self.navigationController?.pushViewController(nav, animated: true)
                                } else {
                                    let nav = StoryTellingViewController()
                                    self.navigationController?.pushViewController(nav, animated: true)
                                }
                            case .failure(let error):
                                print("Kakao Login Error: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if error != nil {
                    self.showKakaoLoginFailMessage()
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self.viewModel.postLoginAPI(socialAccessToken: accessToken, socialType: "KAKAO") { result in
                            switch result {
                            case .success:
                                self.viewModel.checkKakaoUser()
                                if self.viewModel.kakaoEntity!.isMemberDollExist {
                                    UserManager.shared.hasPostMember()
                                    let nav = TabBarController()
                                    self.navigationController?.pushViewController(nav, animated: true)
                                } else {
                                    let nav = StoryTellingViewController()
                                    self.navigationController?.pushViewController(nav, animated: true)
                                }
                            case .failure(let error):
                                print("Kakao Login Error: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func showKakaoLoginFailMessage() {
        print("카카오 로그인 실패")
    }
    
    func appleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let identityToken = appleIDCredential.identityToken
            
            UserManager.shared.setUserIdForApple(userId: userIdentifier)
            
            if let tokenString = String(data: identityToken!, encoding: .utf8) {
                self.viewModel.postLoginAPI(socialAccessToken: tokenString, socialType: "APPLE") { result in
                    switch result {
                    case .success:
                        self.viewModel.checkAppleUser()
                        if self.viewModel.appleEntity!.isMemberDollExist {
                            UserManager.shared.hasPostMember()
                            let nav = TabBarController()
                            self.navigationController?.pushViewController(nav, animated: true)
                        } else {
                            let nav = StoryTellingViewController()
                            self.navigationController?.pushViewController(nav, animated: true)
                        }
                    case .failure(let error):
                        print("Apple Login Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login failed with error: \(error.localizedDescription)")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return  self.view.window!
    }
}
