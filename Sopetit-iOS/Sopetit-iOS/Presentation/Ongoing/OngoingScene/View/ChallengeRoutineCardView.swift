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
        return imageView
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
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
    }
    
    func setHierarchy() {
        
        self.addSubviews(cardImageView, themeImageView, themeLabel, ellipsisButton, routineLabel, completeButton)
        
    }
    
    func setLayout() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(140)
        }
        
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
    }
}

extension ChallengeRoutineCardView {
    func setDataBind(data: ChallengeRoutine) {
        self.themeImageView.image = {
            switch data.themeId {
            case 1:
                return UIImage(resource: .theme1)
            case 2:
                return UIImage(resource: .theme5)
            case 3:
                return UIImage(resource: .theme7)
            case 4:
                return UIImage(resource: .theme2)
            case 5:
                return UIImage(resource: .theme6)
            case 6:
                return UIImage(resource: .theme3)
            case 7:
                return UIImage(resource: .theme4)
            default:
                return UIImage()
            }
        }()
        self.cardImageView.image = {
            switch data.themeId {
            case 1:
                return UIImage(resource: .challenge1)
            case 2:
                return UIImage(resource: .challenge5)
            case 3:
                return UIImage(resource: .challenge7)
            case 4:
                return UIImage(resource: .challenge2)
            case 5:
                return UIImage(resource: .challenge6)
            case 6:
                return UIImage(resource: .challenge3)
            case 7:
                return UIImage(resource: .challenge4)
            default:
                return UIImage(resource: .challenge8)
            }
        }()
        self.themeLabel.text = data.themeName
        self.routineLabel.text = data.content
    }
}
