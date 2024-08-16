//
//  GetCottonView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/25/24.
//

import UIKit

import Lottie
import SnapKit

class GetCottonView: UIView {
    
    let cottonLottieView = LottieAnimationView(name: "daily_complete_ios")
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ActiveRoutine.emptyRoutine
        label.font = .fontGuide(.head3)
        label.textColor = .Gray500
        label.textAlignment = .center
        return label
    }()
    
    let addRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.ActiveRoutine.addChallengeButton, for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption1)
        button.layer.cornerRadius = 21
        button.backgroundColor = .Gray650
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

extension GetCottonView {
    
    func setUI() {
        cottonLottieView.loopMode = .loop
        cottonLottieView.contentMode = .scaleAspectFit
        cottonLottieView.frame = self.bounds
        cottonLottieView.backgroundColor = .clear
    }
    
    func setHierarchy() {
        self.addSubviews(cottonLottieView)
    }
    
    func setLayout() {
        cottonLottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(420)
        }
    }
}
