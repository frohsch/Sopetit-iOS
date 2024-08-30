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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
    
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
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
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    let routineInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let routineInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "루틴메이커 테마란?"
        label.textColor = .Gray700
        label.font = .fontGuide(.head4)
        label.asLineHeight(.head4)
        return label
    }()
    
    private let routineInfoSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전문가들이 만드는 루틴을 직접 실천해 볼 수 있는 테마에요."
        label.numberOfLines = 0
        label.textColor = .Gray650
        label.font = .fontGuide(.caption1)
        label.asLineHeight(.caption1)
        return label
    }()
    
    let routineInfoExitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icExit), for: .normal)
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

private extension AddRoutineView {
    
    func setUI() {
        self.backgroundColor = .Gray50
        backgroundView.isHidden = true
        routineInfoView.isHidden = true
    }
    
    func setHierarchy() {
        addSubviews(navigationView,
                    scrollView,
                    backgroundView,
                    routineInfoView)
        routineInfoView.addSubviews(routineInfoTitleLabel,
                                    routineInfoSubTitleLabel,
                                    routineInfoExitButton)
        scrollView.addSubview(contentView)
        contentView.addSubviews(makerRoutineTitle, makerImageView, makerInfoButton,
                                makerCollectionView,
                                totalRoutineTitle, totalRoutineCollectionView)
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        makerRoutineTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalToSuperview().inset(20)
        }
        
        makerImageView.snp.makeConstraints {
            $0.centerY.equalTo(makerRoutineTitle).offset(2)
            $0.leading.equalTo(makerRoutineTitle.snp.trailing).offset(4)
        }
        
        makerInfoButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview().inset(29)
            $0.size.equalTo(20)
        }
        
        routineInfoView.snp.makeConstraints {
            $0.top.equalTo(makerInfoButton.snp.bottom).offset(-2)
            $0.trailing.equalTo(makerInfoButton.snp.trailing)
            $0.width.equalTo(272)
            $0.height.equalTo(94)
        }
        
        routineInfoTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        routineInfoSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(routineInfoTitleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(routineInfoTitleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        routineInfoExitButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(18)
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
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(630)
        }
    }
    
    func setRegisterCell() {
        MakersCollectionViewCell.register(target: makerCollectionView)
        TotalRoutineCollectionViewCell.register(target: totalRoutineCollectionView)
    }
}
