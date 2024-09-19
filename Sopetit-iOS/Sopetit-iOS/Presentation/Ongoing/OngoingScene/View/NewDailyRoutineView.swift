//
//  NewDailyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 9/6/24.
//

import UIKit

import SnapKit

class NewDailyRoutineView: UIView {
    
    let dailyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ActiveRoutine.dailyTitle
        label.font = .fontGuide(.body3)
        label.textColor = .Gray700
        return label
    }()
    
    let dailyInfoButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("?", for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption2)
        button.setBackgroundColor(.Gray200, for: .normal)
        button.roundCorners(cornerRadius: 4, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    let dailyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        collectionView.isScrollEnabled = false
        collectionView.scrollsToTop = false

        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setHierarchy()
        setLayout()
        setRegister()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewDailyRoutineView {
    
    func setHierarchy() {
        self.addSubviews(dailyTitleLabel, dailyInfoButton, dailyCollectionView)
    }
    
    func setLayout() {
        dailyTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        dailyInfoButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(dailyTitleLabel.snp.centerY)
            $0.size.equalTo(20)
        }
        
        dailyCollectionView.snp.makeConstraints {
            $0.top.equalTo(dailyTitleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1000)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setRegister() {
        NewDailyRoutineCollectionViewCell.register(target: dailyCollectionView)
        NewDailyRoutineHeaderView.register(target: dailyCollectionView)
    }
    
}
