//
//  AddChallengeRoutineCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/12/24.
//

import UIKit

import SnapKit

final class AddChallengeRoutineCollectionViewCell: UICollectionViewCell,
                                                   UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static let isFromNib: Bool = false
    
    var hasRoutine: Bool = false {
        didSet {
            self.backgroundColor = hasRoutine ? .Gray200 : .SoftieWhite
            self.layer.borderColor = hasRoutine ? UIColor.Gray300.cgColor : UIColor.Gray200.cgColor
            challengeChoiceButton.isHidden = hasRoutine ? true : false
            challengeDivideView.backgroundColor = hasRoutine ? .Gray300 : .Gray200
        }
    }
    
    var buttonAction: (() -> Void)?
    
    override var isSelected: Bool {
        didSet {
            challengeChoiceButton.isSelected = isSelected
        }
    }
    
    // MARK: - UI Components
    
    private let challengeRoutineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let challengeDivideView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        return view
    }()
    
    private let challengeDetailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnDetail), for: .normal)
        button.setImage(UIImage(resource: .btnDetail), for: .selected)
        return button
    }()
    
    private let challengeChoiceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnAdd), for: .normal)
        button.setImage(UIImage(resource: .btnCheck), for: .selected)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.isSelected = false
        self.hasRoutine = false
    }
}

// MARK: - Extensions

private extension AddChallengeRoutineCollectionViewCell {
    
    func setUI() {
        self.backgroundColor = .SoftieWhite
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.Gray200.cgColor
        self.layer.borderWidth = 1
    }
    
    func setHierarchy() {
        addSubviews(challengeRoutineLabel,
                    challengeDivideView,
                    challengeDetailButton,
                    challengeChoiceButton)
    }
    
    func setLayout() {
        challengeRoutineLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        challengeDivideView.snp.makeConstraints {
            $0.top.equalTo(challengeRoutineLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        challengeDetailButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(66)
            $0.height.equalTo(30)
        }
        
        challengeChoiceButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(38)
        }
    }
    
    func setAddTarget() {
        challengeDetailButton.addTarget(self,
                                        action: #selector(buttonTapped),
                                        for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        buttonAction?()
    }
}

extension AddChallengeRoutineCollectionViewCell {
    
    func setRoutineChallengeBind(model: Challenge) {
        challengeRoutineLabel.text = model.content.replacingOccurrences(of: "\n", with: " ")
        challengeRoutineLabel.asLineHeight(.body2)
    }
}
