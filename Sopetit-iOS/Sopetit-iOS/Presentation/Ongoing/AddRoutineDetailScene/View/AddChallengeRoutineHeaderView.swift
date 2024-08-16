//
//  AddChallengeRoutineHeaderView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/13/24.
//

import UIKit

import SnapKit

final class AddChallengeRoutineHeaderView: UICollectionReusableView,
                                            UICollectionHeaderViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib = false
    
    // MARK: - UI Components
    
    private let challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddChallengeRoutineHeaderView {
    
    func setUI() {
        backgroundColor = .clear
    }
    
    func setHierarchy() {
        addSubview(challengeTitleLabel)
    }
    
    func setLayout() {
        challengeTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(7)
            $0.top.equalToSuperview().inset(20)
        }
    }
}

extension AddChallengeRoutineHeaderView {
    
    func setChallengeHeaderBind(headerTitle: String) {
        challengeTitleLabel.text = headerTitle
    }
}
