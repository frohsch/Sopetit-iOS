//
//  AddRoutineView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/27/24.
//

import UIKit

import SnapKit

final class AddRoutineView: UIView {
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBarView = {
        let navi = CustomNavigationBarView()
        navi.isBackButtonIncluded = true
        navi.isTitleViewIncluded = true
        navi.isTitleLabelIncluded = "루틴 추가"
        return navi
    }()
    
    private let makerRoutineTitle: UILabel = {
        let label = UILabel()
        label.text = "이런 루틴은 어때요?"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    private let makerImageView = UIImageView(image: UIImage(resource: .imgMaker))
    
    let makerInfoButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("?", for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption2)
        button.setBackgroundColor(.Gray200, for: .normal)
        button.roundCorners(cornerRadius: 4, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    lazy var makerCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.itemSize = CGSize(width: 254, height: 168)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    private let totalRoutineTitle: UILabel = {
        let label = UILabel()
        label.text = "전체 루틴 테마"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    lazy var totalRoutineCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40,
                                     height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
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

private extension AddRoutineView {
    
    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        addSubviews(navigationView,
                    makerRoutineTitle, makerImageView, makerInfoButton,
                    makerCollectionView,
                    totalRoutineTitle, totalRoutineCollectionView)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        makerRoutineTitle.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(19)
            $0.leading.equalToSuperview().inset(20)
        }
        
        makerImageView.snp.makeConstraints {
            $0.centerY.equalTo(makerRoutineTitle).offset(2)
            $0.leading.equalTo(makerRoutineTitle.snp.trailing).offset(4)
        }
        
        makerInfoButton.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(21)
            $0.trailing.equalToSuperview().inset(29)
            $0.size.equalTo(20)
        }
        
        makerCollectionView.snp.makeConstraints {
            $0.top.equalTo(makerRoutineTitle.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
            $0.height.equalTo(168)
        }
        
        totalRoutineTitle.snp.makeConstraints {
            $0.top.equalTo(makerCollectionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        totalRoutineCollectionView.snp.makeConstraints {
            $0.top.equalTo(totalRoutineTitle.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
            $0.height.equalTo(584)
        }
    }
    
    func setRegisterCell() {
        MakersCollectionViewCell.register(target: makerCollectionView)
        TotalRoutineCollectionViewCell.register(target: totalRoutineCollectionView)
    }
}
