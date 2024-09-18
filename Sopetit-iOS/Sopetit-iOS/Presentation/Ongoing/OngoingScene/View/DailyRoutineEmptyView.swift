//
//  DailyRoutineEmptyView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 9/6/24.
//

import UIKit

import SnapKit

class DailyRoutineEmptyView: UIView {
    
    let bearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.ActiveRoutine.emptyroutine
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ActiveRoutine.emptyRoutine
        label.font = .fontGuide(.body2)
        label.textColor = .Gray500
        label.textAlignment = .center
        return label
    }()
    
    let addRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.ActiveRoutine.addChallengeButton, for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption1)
        button.layer.cornerRadius = 21
        button.backgroundColor = .Gray200
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Gray400.cgColor
        return button
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

extension DailyRoutineEmptyView {
    
    func setUI() {
    }
    
    func setHierarchy() {
        self.addSubviews(bearImageView, titleLabel, addRoutineButton)
    }
    
    func setLayout() {
        bearImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bearImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(24)
        }
        
        addRoutineButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(98)
            $0.height.equalTo(42)
        }
    }
}
