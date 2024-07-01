//
//  ChallengeRoutineCardView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

import SnapKit

class ChallengeRoutineCardView: UIView {
    
    private let themeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.ActiveRoutine.theme
        return imageView
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "관계 쌓기"
        label.font = .fontGuide(.caption1)
        label.textColor = .Gray500
        return label
    }()
    
    let ellipsisButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.ActiveRoutine.icnMore, for: .normal)
        return button
    }()
    
    private let routineLabel: UILabel = {
        let label = UILabel()
        label.text = "주변인의 관심사와 작은 변화를 기록해보고, \n그 사람의 장점을 생각해보기"
        label.font = .fontGuide(.body2)
        label.textColor = .Gray700
        label.setTextWithLineHeight(text: label.text, lineHeight: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.ActiveRoutine.complete, for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption1)
        button.setBackgroundColor(.Gray650, for: .normal)
        button.roundCorners(cornerRadius: 17, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.ActiveRoutine.challengeCard
        return imageView
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

private extension ChallengeRoutineCardView {
    
    func setUI() {
        self.layer.borderColor = UIColor.Gray200.cgColor
        self.layer.borderWidth = 1
        self.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        self.backgroundColor = .Pink50
    }
    
    func setHierarchy() {
        
        self.addSubviews(themeImageView, themeLabel, ellipsisButton, cardImageView, routineLabel, completeButton)
        
    }
    
    func setLayout() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(140)
        }
        
        themeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalTo(ellipsisButton.snp.centerY)
            $0.size.equalTo(16)
        }
        
        themeLabel.snp.makeConstraints {
            $0.leading.equalTo(themeImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(ellipsisButton.snp.centerY)
        }
        
        ellipsisButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        
        routineLabel.snp.makeConstraints {
            $0.top.equalTo(ellipsisButton.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(66)
            $0.height.equalTo(34)
        }
        
        cardImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
