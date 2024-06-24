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
    
    private let ongoingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
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
        ongoingStackView.addArrangedSubviews(ongoingReadyImage, ongoingReadyTitle)
        self.addSubview(ongoingStackView)
    }
    
    func setLayout() {
        ongoingStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(SizeLiterals.Screen.screenHeight * 210 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(147)
        }
        
        ongoingReadyImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(110)
            $0.height.equalTo(120)
        }
        
        ongoingReadyTitle.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
