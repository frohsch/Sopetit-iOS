//
//  DollChoiceView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

import SnapKit

final class DollChoiceView: UIView {
    
    // MARK: - UI Components
    
    private let progressView = CustomProgressView(progressNum: 1)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.dollChoiceTitle
        label.font = .fontGuide(.head1)
        label.asLineHeight(.head1)
        label.textColor = .Gray700
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.dollSubTitle
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        label.textColor = .Gray500
        return label
    }()
    
    lazy var dollCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.itemSize = CGSize(width: 160, height: 160)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .Gray50
        return collectionView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.buttonTitle, for: .normal)
        button.setTitleColor(.SoftieWhite, for: .disabled)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.setBackgroundColor(.Gray300, for: .disabled)
        button.setBackgroundColor(.Gray650, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DollChoiceView {

    func setUI() {
        backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        addSubviews(progressView, titleLabel, subTitleLabel, dollCollectionView, nextButton)
    }
    
    func setLayout() {
        progressView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(23)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        dollCollectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 102 / 812)
            $0.centerX.equalToSuperview().inset(20)
            $0.size.equalTo(335)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 17 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(56)
        }
    }
    
    func setRegisterCell() {
        DollChoiceCollectionViewCell.register(target: dollCollectionView)
    }
}
