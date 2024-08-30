//
//  GetRainbowCottonView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 8/29/24.
//

import UIKit

import Lottie
import SnapKit

class GetRainbowCottonView: UIView {
    
    let cottonLottieView = LottieAnimationView(name: "happy_complete_ios")
    
    let toastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastRainbow
        return imageView
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

extension GetRainbowCottonView {
    
    func setUI() {
        cottonLottieView.loopMode = .loop
        cottonLottieView.contentMode = .scaleAspectFit
        cottonLottieView.frame = self.bounds
        cottonLottieView.backgroundColor = .clear
    }
    
    func setHierarchy() {
        self.addSubviews(cottonLottieView, toastImageView)
    }
    
    func setLayout() {
        cottonLottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(420)
        }
        
        toastImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
    }
}
