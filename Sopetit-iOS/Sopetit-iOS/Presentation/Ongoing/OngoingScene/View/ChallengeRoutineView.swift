//
//  ChallengeRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 9/6/24.
//

import UIKit

import SnapKit

class ChallengeRoutineView: UIView {
    
    private let challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ActiveRoutine.challengeTitle
        label.font = .fontGuide(.body3)
        label.textColor = .Gray700
        return label
    }()
    
    let challengeInfoButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("?", for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption2)
        button.setBackgroundColor(.Gray200, for: .normal)
        button.roundCorners(cornerRadius: 4, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    let challengeRoutineCardView = ChallengeRoutineCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChallengeRoutineView {
    
    func setHierarchy() {
        self.addSubviews(challengeTitleLabel, challengeInfoButton, challengeRoutineCardView)
    }
    
    func setLayout() {
        
        challengeInfoButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
        
        challengeTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(challengeInfoButton.snp.centerY)
            $0.leading.equalToSuperview().inset(20)
        }
        
        challengeRoutineCardView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
