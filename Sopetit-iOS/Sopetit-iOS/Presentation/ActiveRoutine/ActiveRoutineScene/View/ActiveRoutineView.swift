//
//  ActiveRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

import SnapKit

class ActiveRoutineView: UIView {
    
    private let dateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head3)
        label.textColor = .Gray700
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private let challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ActiveRoutine.challengeTitle
        label.font = .fontGuide(.body3)
        label.textColor = .Gray700
        return label
    }()
    
    let challengeInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("?", for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption2)
        button.setBackgroundColor(.Gray200, for: .normal)
        button.roundCorners(cornerRadius: 4, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    let challengeRoutineCardView = ChallengeRoutineCardView()
    
    let divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        return view
    }()
    
    let dailyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ActiveRoutine.dailyTitle
        label.font = .fontGuide(.body3)
        label.textColor = .Gray700
        return label
    }()
    
    let dailyInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("?", for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption2)
        button.setBackgroundColor(.Gray200, for: .normal)
        button.roundCorners(cornerRadius: 4, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    let dailyContentView: UIView = {
        let view = UIView()
        return view
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
        collectionView.backgroundColor = .SoftieBack
        return collectionView
    }()
    
    let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.ActiveRoutine.icnAddButton, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let button = self as? UIButton {
            let buttonFrame = CGRect(
                x: button.bounds.origin.x - (38 - button.bounds.origin.x)/2,
                y: button.bounds.origin.y - (38 - button.bounds.origin.y)/2,
                width: 38,
                height: 38
            )
            if buttonFrame.contains(point) {
                return button
            }
        }
        return super.hitTest(point, with: event)
    }
}

private extension ActiveRoutineView {
    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubviews(dateView, scrollView, floatingButton)
        dateView.addSubview(dateLabel)
        self.scrollView.addSubviews(dailyContentView)
        
        self.dailyContentView.addSubviews(challengeTitleLabel, challengeInfoButton, challengeRoutineCardView, divisionView, dailyTitleLabel, dailyInfoButton, dailyCollectionView
        )
        
    }
    
    func setLayout() {
        dateView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        dailyContentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        challengeInfoButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(challengeTitleLabel.snp.centerY)
            $0.size.equalTo(20)
        }
        
        challengeRoutineCardView.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
        }
        
        divisionView.snp.makeConstraints {
            $0.top.equalTo(challengeRoutineCardView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        dailyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divisionView.snp.bottom).offset(16)
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
        
        floatingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
            $0.size.equalTo(50)
        }
    }
    
    func setDateLabel() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        let formattedDate = dateFormatter.string(from: currentDate)
        dateLabel.text = formattedDate
    }
}
