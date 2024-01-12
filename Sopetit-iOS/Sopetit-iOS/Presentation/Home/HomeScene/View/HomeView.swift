//
//  HomeView.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/9/24.
//

import UIKit

import SnapKit
import Lottie

final class HomeView: UIView {
    
    // MARK: - Properties
    
    var isAnimate: Bool = false
    
    // MARK: - UI Components
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.imgHomebackAllGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let softieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.icLogoHome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var moneyButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Home.icHomeMoney, for: .normal)
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Home.icHomeSettings, for: .normal)
        return button
    }()
    
    private let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Home.pngSpeechHome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var lottieHello = LottieAnimationView(name: "gray_hello")
    var lottieEatingDaily = LottieAnimationView(name: "gray_eating_daily")
    var lottieEatingHappy = LottieAnimationView(name: "gray_eating_happy")
    
    private let bubbleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .fontGuide(.bubble18)
        return label
    }()
    
    let dollNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.bubble16)
        label.backgroundColor = UIColor.SoftieHomeFill
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.SoftieHomeStroke.cgColor
        label.layer.cornerRadius = 17
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var actionCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = SizeLiterals.Screen.screenWidth * 4 / 375
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth * 160 / 375, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension HomeView {
    
    func setUI() {
        lottieHello.isHidden = false
        lottieEatingDaily.isHidden = true
        lottieEatingHappy.isHidden = true
    }
    
    func setHierarchy() {
        self.addSubviews(backgroundImageView, softieImageView, moneyButton, settingButton, bubbleImageView, dollNameLabel, actionCollectionView)
        
        bubbleImageView.addSubview(bubbleLabel)
        
        addSubview(lottieEatingDaily)
        addSubview(lottieEatingHappy)
        addSubview(lottieHello)
    }
    
    func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        softieImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(55)
            $0.leading.equalToSuperview().inset(20)
        }
        
        moneyButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalTo(settingButton)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-20)
        }
        
        settingButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview().inset(52)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(68)
            $0.top.equalTo(lottieHello.snp.top).inset(22)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-4)
        }
        
        lottieEatingDaily.snp.makeConstraints {
            $0.width.equalTo(414)
            $0.height.equalTo(418)
            $0.center.equalToSuperview()
        }
        
        lottieEatingHappy.snp.makeConstraints {
            $0.width.equalTo(414)
            $0.height.equalTo(418)
            $0.center.equalToSuperview()
        }
        
        lottieHello.snp.makeConstraints {
            $0.width.equalTo(414)
            $0.height.equalTo(418)
            $0.center.equalToSuperview()
        }
        
        dollNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(lottieHello.snp.bottom).inset(54)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(63)
            $0.height.equalTo(34)
        }
        
        actionCollectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(106)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 331 / 375)
            $0.height.equalTo(100)
        }
    }
    
    func setAddTarget() {
        let dollTapGesture: UIGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dollTapped)
        )
        lottieHello.addGestureRecognizer(dollTapGesture)
    }
    
    @objc
    func dollTapped() {
        print("인형을 탭함.")
        
        if !(isAnimate) {
            isAnimate = true
            lottieHello.isHidden = false
            lottieEatingDaily.isHidden = true
            lottieEatingHappy.isHidden = true
            lottieHello.loopMode = .playOnce
            lottieHello.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                self.isAnimate = false
            }
        }
    }
    
    func setRegisterCell() {
        ActionCollectionViewCell.register(target: actionCollectionView)
    }
    
    func setDataBind(model: HomeEntity) {
        bubbleLabel.text = model.conversation
        dollNameLabel.text = model.name
    }
}
