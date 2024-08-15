//
//  RoutineChoiceView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit

final class RoutineChoiceView: UIView {

    // MARK: - UI Components
    
    let navigationView: CustomNavigationBarView = {
        let navi = CustomNavigationBarView()
        navi.isBackButtonIncluded = true
        return navi
    }()
    
    private let progressView = CustomProgressView(progressNum: 4)
    
    private let bearImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Onboarding.imgFaceBrown
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 14
        stackview.alignment = .center
        return stackview
    }()
    
    private let bubbleImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Onboarding.svgSpeechLong
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let bubbleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.routineChoiceTitle
        label.textColor = .Gray700
        label.font = .fontGuide(.bubble2)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var themeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 4
        flowLayout.itemSize = CGSize(width: (SizeLiterals.Screen.screenWidth - 57) / 3, height: 34)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .Gray200
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        collectionView.layer.cornerRadius = 8
        return collectionView
    }()
    
    lazy var routineFirstCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 56)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    lazy var routineSecondCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 56)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    lazy var routineThirdCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 56)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.routineBackButtonTitle, for: .disabled)
        button.setTitle(I18N.Onboarding.routineNextButtonTitle, for: .normal)
        button.setTitleColor(.SoftieWhite, for: .disabled)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.setBackgroundColor(.Gray300, for: .disabled)
        button.setBackgroundColor(.Gray650, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
    
    private lazy var bottomLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.SoftieWhite.withAlphaComponent(0).cgColor, UIColor.SoftieWhite.withAlphaComponent(1).cgColor]
        return gradient
    }()
    
    private let toastView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray400
        view.layer.cornerRadius = 22
        return view
    }()
    
    let toastStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 6
        stackview.alignment = .center
        return stackview
    }()
    
    private let toastImage = UIImageView(image: UIImage(resource: .icWarning))
    
    private let toastLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.toastTitle
        label.textColor = .SoftieWhite
        label.textAlignment = .center
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        topLayer.frame = CGRect(x: SizeLiterals.Screen.screenWidth * 20 / 375,
//                                    y: collectionView.frame.origin.y,
//                                    width: SizeLiterals.Screen.screenWidth * 335 / 375,
//                                    height: 30)
//        self.layer.addSublayer(topLayer)
//        let collectionViewBottomY = collectionView.frame.origin.y + collectionView.frame.size.height
//        bottomLayer.frame = CGRect(x: SizeLiterals.Screen.screenWidth * 20 / 375,
//                                   y: collectionViewBottomY - 30,
//                                   width: SizeLiterals.Screen.screenWidth * 335 / 375,
//                                   height: 30)
//        self.layer.addSublayer(bottomLayer)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension RoutineChoiceView {

    func setUI() {
        backgroundColor = .Gray50
        routineSecondCollectionView.isHidden = true
        routineThirdCollectionView.isHidden = true
        toastView.isHidden = true
    }
    
    func setHierarchy() {
        stackview.addArrangedSubviews(bearImage, bubbleImage)
        toastStackview.addArrangedSubviews(toastImage, toastLabel)
        bubbleImage.addSubview(bubbleLabel)
        toastView.addSubview(toastStackview)
        addSubviews(navigationView, progressView, stackview, themeCollectionView, nextButton,
                    routineFirstCollectionView, routineSecondCollectionView, routineThirdCollectionView, toastView)
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
        
        themeCollectionView.snp.makeConstraints {
            $0.top.equalTo(bubbleImage.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 20 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 41)
            $0.height.equalTo(42)
        }
        
        routineFirstCollectionView.snp.makeConstraints {
            $0.top.equalTo(themeCollectionView.snp.bottom).offset(5)
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.centerX.equalToSuperview()
        }
        
        routineSecondCollectionView.snp.makeConstraints {
            $0.top.equalTo(themeCollectionView.snp.bottom).offset(5)
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.centerX.equalToSuperview()
        }
        
        routineThirdCollectionView.snp.makeConstraints {
            $0.top.equalTo(themeCollectionView.snp.bottom).offset(5)
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 17 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(56)
        }
        
        toastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top).offset(-16)
            $0.width.equalTo(184)
            $0.height.equalTo(44)
        }
        
        toastStackview.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        toastImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
    }
    
    func setRegisterCell() {
        RoutineThemeCollectionViewCell.register(target: themeCollectionView)
        RoutineChoiceCollectionViewCell.register(target: routineFirstCollectionView)
        RoutineChoiceCollectionViewCell.register(target: routineSecondCollectionView)
        RoutineChoiceCollectionViewCell.register(target: routineThirdCollectionView)
    }
    
    func setDataBind(model: DollImageEntity) {
        bearImage.kfSetImage(url: model.faceImageURL)
    }
    
    func setToastMessage() {
        toastView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
            self.toastView.alpha = 0.0
        })
    }
}
