//
//  AchieveView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/27/24.
//

import UIKit

import SnapKit

final class AchieveView: UIView {
    
    // MARK: - UI Components
    
    private let ongoingReadyImage = UIImageView(image: UIImage(resource: .imgAchieveReady))
    
    private let ongoingReadyTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Ongoing.ongoingReadyTitle
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.numberOfLines = 0
        label.asLineHeight(.head3)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AchieveView {
    
    func setUI() {
        self.backgroundColor = .Gray50
        ongoingReadyImage.contentMode = .scaleAspectFit
    }
    
    func setHierarchy() {
        addSubviews(ongoingReadyImage,
                    ongoingReadyTitle)
    }
    
    func setLayout() {
        ongoingReadyImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(SizeLiterals.Screen.screenHeight * 210 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(110)
            $0.height.equalTo(120)
        }
        
        ongoingReadyTitle.snp.makeConstraints {
            $0.top.equalTo(ongoingReadyImage.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }
}
