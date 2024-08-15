//
//  TutorialView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/3/24.
//

import UIKit

import SnapKit

final class TutorialView: UIView {
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray950.withAlphaComponent(0.5)
        return view
    }()
    
    private let tutorialView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        return view
    }()

    lazy var tutorialCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth * 320 / 375, height: 385)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 320, height: 30))
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = .Gray300
        pageControl.currentPageIndicatorTintColor = .Gray650
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return pageControl
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.backgroundColor = .Gray650
        button.layer.cornerRadius = 10
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

extension TutorialView {
    
    func setUI() {
        backgroundColor = .clear
    }
    
    func setHierarchy() {
        addSubviews(backgroundView, tutorialView)
        tutorialView.addSubviews(tutorialCollectionView, nextButton, pageControl)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tutorialView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(567)
        }
        
        tutorialCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 320 / 375)
            $0.height.equalTo(385)
        }
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-32)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
    }
    
    func setRegisterCell() {
        TutorialCollectionViewCell.register(target: tutorialCollectionView)
    }
}
