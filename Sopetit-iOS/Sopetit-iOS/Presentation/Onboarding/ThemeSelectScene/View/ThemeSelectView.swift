//
//  ThemeSelectView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit

final class ThemeSelectView: UIView {

    // MARK: - UI Components
    
    let navigationView: CustomNavigationBarView = {
        let navi = CustomNavigationBarView()
        navi.isBackButtonIncluded = true
        return navi
    }()
    
    private let progressView = CustomProgressView(progressNum: 3)
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 14
        stackview.alignment = .center
        return stackview
    }()
    
    private let bearImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .variant6)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let bubbleImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Onboarding.svgSpeechLong
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var bubbleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.bubble2)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .Gray50
        return collectionView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.themeButtonTitle, for: .normal)
        button.setTitleColor(.Gray300, for: .disabled)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.setBackgroundColor(.Gray100, for: .disabled)
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
        setGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension ThemeSelectView {

    func setUI() {
        backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        stackview.addArrangedSubviews(bearImage, bubbleImage)
        bubbleImage.addSubview(bubbleLabel)
        addSubviews(navigationView, progressView, collectionView, nextButton, backgroundView, stackview)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(5)
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bearImage.snp.makeConstraints {
            $0.width.equalTo(53)
            $0.height.equalTo(50)
        }
        
        bubbleImage.snp.makeConstraints {
            $0.width.equalTo(248)
            $0.height.equalTo(60)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        stackview.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bubbleImage.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 37 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(190)
            $0.height.equalTo(400)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 17 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(56)
        }
    }

    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func viewTapped() {
        backgroundView.isHidden = true
        bubbleLabel.text = I18N.Onboarding.themeTitle
    }
    
    func setRegisterCell() {
        ThemeSelectCollectionViewCell.register(target: collectionView)
    }
    
    func setDataBind(model: DollImageEntity) {
        bearImage.kfSetImage(url: model.faceImageURL)
    }
}
