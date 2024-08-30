//
//  LogoutBSViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/30/24.
//

import UIKit

import SnapKit

final class LogoutBSViewController: UIViewController {
    
    // MARK: - Properties
    
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 291 / 812
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray950
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomSheet: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .imgFaceCrying)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.BottomSheet.logoutTitle
        label.font = .fontGuide(.head1)
        label.textColor = .Gray700
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.BottomSheet.logoutSubTitle
        label.font = .fontGuide(.body2)
        label.textColor = .Gray500
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Gray100
        button.setTitle("더 생각해볼래", for: .normal)
        button.setTitleColor(.Gray400, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Red200
        button.setTitle("로그아웃 할래", for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDismissAction()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

extension LogoutBSViewController {
    
    func setUI() {
        view.backgroundColor = .clear
    }
    
    func setHierarchy() {
        bottomSheet.addSubviews(imageView,
                                titleLabel,
                                subTitleLabel,
                                leftButton,
                                rightButton)
        view.addSubviews(backgroundView,
                         bottomSheet)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(66)
            $0.height.equalTo(61)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            } else {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 36 / 812)
            }
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 162 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
        
        rightButton.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            } else {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 36 / 812)
            }
            $0.trailing.equalToSuperview().inset(21)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 162 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
    }
    
    func showBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - self.bottomHeight)
            }
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundView.backgroundColor = .Gray1000
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func setDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func hideBottomSheetAction() {
        hideBottomSheet()
    }
    
    func setAddTarget() {
        leftButton.addTarget(self,
                                    action: #selector(hideBottomSheetAction),
                                    for: .touchUpInside)
        rightButton.addTarget(self,
                                    action: #selector(postLogoutAPI),
                                    for: .touchUpInside)
    }
}

extension LogoutBSViewController {
    
    @objc
    func postLogoutAPI() {
        AuthService.shared.postLogoutAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if data is GenericResponse<LogoutEntity> {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let keyWindow = windowScene.windows.first else {
                        return
                    }
                    UserManager.shared.clearAll()
                    let nav = LoginViewController()
                    keyWindow.rootViewController = UINavigationController(rootViewController: nav)
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}
