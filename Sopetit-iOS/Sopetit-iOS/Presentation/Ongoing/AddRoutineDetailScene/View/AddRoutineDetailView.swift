//
//  AddRoutineDetailView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/12/24.
//

import UIKit

import SnapKit

final class AddRoutineDetailView: UIView {
    
    private var theme: AddRoutineTheme
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBarView = {
        let navi = CustomNavigationBarView()
        navi.isBackButtonIncluded = true
        navi.backgroundColor = .clear
        return navi
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        return scrollView
    }()
    private let contentView = UIView()
    
    private let cardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "관계 쌓기"
        label.textColor = .white
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    private let cardImageView = UIImageView()
    private let makerImageView = UIImageView()
    
    private let makerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "침착맨"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    private let cardDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "예시\n아아"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .Gray500
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let makerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnMaker), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.layer.cornerRadius = 22
        return button
    }()
    
    let dailyMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let dailyStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 4
        return stackview
    }()
    
    private let dailyRoutineTitle: UILabel = {
        let label = UILabel()
        label.text = "데일리 루틴"
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let dailyRoutineCount: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let dailyUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray650
        return view
    }()
    
    let challengeMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let challengeStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 4
        return stackview
    }()
    
    private let challengeRoutineTitle: UILabel = {
        let label = UILabel()
        label.text = "도전 루틴"
        label.textColor = .Gray400
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let challengeRoutineCount: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let challengeUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray650
        view.isHidden = true
        return view
    }()
    
    let menuUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        return view
    }()
    
    lazy var routineDailyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    lazy var challengeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.headerReferenceSize = CGSize(width: SizeLiterals.Screen.screenWidth - 55,
                                                height: 44)
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    init(info: AddRoutineInfoEntity) {
        self.theme = info.themeStyle
        super.init(frame: .zero)
        
        bindUI(info: info)
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

private extension AddRoutineDetailView {
    
    func bindUI(info: AddRoutineInfoEntity) {
        switch info.themeStyle {
        case .maker:
            cardTitleLabel.text = info.title
            cardDescriptionLabel.text = info.description
            cardDescriptionLabel.asLineHeight(.body2)
            makerNameLabel.isHidden = false
            makerNameLabel.text = info.name
            cardImageView.image = UIImage(resource: .makerCard)
            makerImageView.kfSetImage(url: info.img)
            makerButton.isHidden = false
            dailyMenuView.isHidden = true
        case .routine:
            cardTitleLabel.text = info.title
            cardDescriptionLabel.text = info.description
            cardDescriptionLabel.asLineHeight(.body2)
            cardImageView.image = {
                switch info.id {
                case 1:
                    return UIImage(resource: .cardTheme1)
                case 2:
                    return UIImage(resource: .cardTheme5)
                case 3:
                    return UIImage(resource: .cardTheme7)
                case 4:
                    return UIImage(resource: .cardTheme2)
                case 5:
                    return UIImage(resource: .cardTheme6)
                case 6:
                    return UIImage(resource: .cardTheme3)
                case 7:
                    return UIImage(resource: .cardTheme4)
                default:
                    return UIImage()
                }
            }()
            makerImageView.isHidden = true
            makerNameLabel.text = ""
            makerNameLabel.isHidden = true
            makerButton.isHidden = true
            dailyMenuView.isHidden = false
        }
    }
    
    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        addSubviews(scrollView,
                    navigationView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(cardImageView,
                                makerNameLabel,
                                cardDescriptionLabel,
                                makerButton,
                                menuUnderlineView,
                                dailyMenuView,
                                challengeMenuView,
                                routineDailyCollectionView
        )
        cardImageView.addSubviews(cardTitleLabel,
                                  makerImageView)
        dailyMenuView.addSubviews(dailyStackView,
                                  dailyUnderLine)
        dailyStackView.addArrangedSubviews(dailyRoutineTitle,
                                           dailyRoutineCount)
        challengeMenuView.addSubviews(challengeStackView,
                                  challengeUnderLine)
        challengeStackView.addArrangedSubviews(challengeRoutineTitle,
                                           challengeRoutineCount)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        cardImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 256 / 812)
        }
        
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 100 / 812)
            $0.centerX.equalToSuperview()
        }
        
        makerImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(7)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(105)
        }
        
        makerNameLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        cardDescriptionLabel.snp.makeConstraints {
            switch theme {
            case .maker:
                $0.top.equalTo(makerNameLabel.snp.bottom).offset(4)
            case .routine:
                $0.top.equalTo(cardImageView.snp.bottom).offset(16)
            }
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        makerButton.snp.makeConstraints {
            $0.top.equalTo(cardDescriptionLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 55)
            $0.height.equalTo(44)
        }
        
        menuUnderlineView.snp.makeConstraints {
            switch theme {
            case .maker:
                $0.top.equalTo(makerButton.snp.bottom).offset(52)
            case .routine:
                $0.top.equalTo(cardDescriptionLabel.snp.bottom).offset(52)
            }
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        dailyMenuView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(menuUnderlineView.snp.bottom)
            $0.width.equalTo(104)
            $0.height.equalTo(38)
        }
        
        dailyStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
        }
        
        dailyUnderLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        challengeMenuView.snp.makeConstraints {
            switch theme {
            case .maker:
                $0.leading.equalToSuperview().inset(27)
            case .routine:
                $0.leading.equalTo(dailyMenuView.snp.trailing)
            }
            $0.bottom.equalTo(menuUnderlineView.snp.bottom)
            $0.width.equalTo(104)
            $0.height.equalTo(38)
        }
        
        challengeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
        }
        
        challengeUnderLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        routineDailyCollectionView.snp.makeConstraints {
            $0.top.equalTo(menuUnderlineView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
        }
    }
    
    func setRegisterCell() {
        RoutineChoiceCollectionViewCell.register(target: routineDailyCollectionView)
        AddChallengeRoutineCollectionViewCell.register(target: challengeCollectionView)
        AddChallengeRoutineHeaderView.register(target: challengeCollectionView)
    }
}

extension AddRoutineDetailView {
    
    func setMenuSelected(dailyTapped: Bool) {
        [dailyRoutineTitle,
         dailyRoutineCount].forEach {
            $0.textColor = dailyTapped ? .Gray700 : .Gray400
        }
        [challengeRoutineTitle,
         challengeRoutineCount].forEach {
            $0.textColor = dailyTapped ? .Gray400 : .Gray700
        }
        dailyUnderLine.isHidden = dailyTapped ? false : true
        challengeUnderLine.isHidden = dailyTapped ? true : false
        
        if dailyTapped {
            challengeCollectionView.removeFromSuperview()
            contentView.addSubview(routineDailyCollectionView)
            routineDailyCollectionView.snp.makeConstraints {
                $0.top.equalTo(menuUnderlineView.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            }
        } else {
            routineDailyCollectionView.removeFromSuperview()
            contentView.addSubview(challengeCollectionView)
            challengeCollectionView.snp.makeConstraints {
                $0.top.equalTo(menuUnderlineView.snp.bottom)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            }
        }
    }
}
