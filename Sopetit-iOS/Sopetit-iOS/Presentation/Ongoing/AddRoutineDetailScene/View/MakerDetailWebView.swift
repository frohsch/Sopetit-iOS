//
//  MakerDetailWebView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/30/24.
//

import UIKit

import SnapKit
import WebKit

final class MakerDetailWebView: UIView {
    
    // MARK: - UI Components
    
    let webNavigationView: CustomNavigationBarView = {
        let navi = CustomNavigationBarView()
        navi.isBackButtonIncluded = true
        navi.backgroundColor = .SoftieWhite
        return navi
    }()
    
    var webView = WKWebView()
    
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

private extension MakerDetailWebView {
    
    func setUI() {
        backgroundColor = .SoftieWhite
    }
    
    func setHierarchy() {
        addSubviews(webNavigationView,
                    webView)
    }
    
    func setLayout() {
        webNavigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(webNavigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
