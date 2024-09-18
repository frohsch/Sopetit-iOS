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
    
}
