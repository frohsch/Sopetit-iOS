//
//  LoginViewModel.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 2/29/24.
//

import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

class LoginViewModel {
    
    // MARK: - Properties
    
    var kakaoEntity: LoginEntity?
    var appleEntity: LoginEntity?
    
    // MARK: - Network
    
    func postLoginAPI(socialAccessToken: String, socialType: String, completion: @escaping (Result<Void, Error>) -> Void) {
        AuthService.shared.postLoginAPI(socialAccessToken: socialAccessToken, socialType: socialType) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<LoginEntity> {
                    switch socialType {
                    case "KAKAO":
                        if let kakaoData = data.data {
                            UserManager.shared.updateSocialType(socialType)
                            self.kakaoEntity = kakaoData
                            completion(.success(()))
                        }
                    case "APPLE":
                        if let appleData = data.data {
                            UserManager.shared.updateSocialType(socialType)
                            self.appleEntity = appleData
                            completion(.success(()))
                        }
                    default:
                        break
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func checkKakaoUser() {
        guard let kakaoEntity = kakaoEntity else { return }
        UserManager.shared.updateToken(kakaoEntity.accessToken, kakaoEntity.refreshToken)
    }
    
    func checkAppleUser() {
        guard let appleEntity = appleEntity else { return }
        UserManager.shared.updateToken(appleEntity.accessToken, appleEntity.refreshToken)
    }
}
