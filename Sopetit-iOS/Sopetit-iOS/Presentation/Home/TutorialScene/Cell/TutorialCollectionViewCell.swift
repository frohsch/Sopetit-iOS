//
//  TutorialCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/3/24.
//

import UIKit

import SnapKit

final class TutorialCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let tutorialKeywordLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head3)
        label.textColor = .Gray700
        label.asLineHeight(.head3)
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.backgroundColor = .Gray200
        label.textAlignment = .center
        return label
    }()
    
    private let tutorialTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head3)
        label.textColor = UIColor.Gray700
        label.asLineHeight(.head3)
        label.textAlignment = .center
        return label
    }()
    
    private let tutorialDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = UIColor.Gray500
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let tutorialImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension TutorialCollectionViewCell {

    func setUI() {
        backgroundColor = .clear
    }
    
    func setHierarchy() {
        addSubviews(tutorialKeywordLabel, tutorialTitleLabel, tutorialDescriptionLabel, tutorialImageView)
    }
    
    func setLayout() {
        tutorialKeywordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(105)
            $0.height.equalTo(40)
        }

        tutorialTitleLabel.snp.makeConstraints {
            $0.top.equalTo(tutorialKeywordLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        tutorialDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(tutorialTitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        tutorialImageView.snp.makeConstraints {
            $0.top.equalTo(tutorialDescriptionLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.deviceRatio > 0.5 ? SizeLiterals.Screen.screenWidth * 320 / 375 : 320)
            $0.height.equalTo(SizeLiterals.Screen.deviceRatio > 0.5 ? SizeLiterals.Screen.screenHeight * 240 / 812 : 240)
        }
    }
}

extension TutorialCollectionViewCell {
    
    func setDataBind(model: HomeTutorialEntity) {
        tutorialKeywordLabel.text = model.tutorial
        tutorialTitleLabel.text = model.title
        tutorialDescriptionLabel.text = model.description
        tutorialImageView.image = model.img
        tutorialDescriptionLabel.textAlignment = .center
        tutorialDescriptionLabel.setLineHeightWithRangeText(text: model.description,
                                                            fontStyle: .body2,
                                                            targetStrings: model.keyword,
                                                            textColor: .Gray700)
        let labelWidth = tutorialKeywordLabel.intrinsicContentSize.width + 32
        tutorialKeywordLabel.snp.updateConstraints {
            $0.width.equalTo(labelWidth)
        }
    }
}
