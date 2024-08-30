//
//  MakerDetailWebViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/30/24.
//

import UIKit

final class MakerDetailWebViewController: UIViewController {
    
    var webUrl: String = ""
    
    private var makerDetailWebView = MakerDetailWebView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = makerDetailWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setURL()
    }
}

extension MakerDetailWebViewController {
    
    func setUI() {
        
    }
    
    func setDelegate() {
        makerDetailWebView.webNavigationView.delegate = self
    }
    
    func setURL() {
        makerDetailWebView.webView.isHidden = false
        makerDetailWebView.webNavigationView.isHidden = false
        
        guard let url = URL(string: webUrl) else { return }
        let request = URLRequest(url: url)
        
        makerDetailWebView.webView.load(request)
    }
}

extension MakerDetailWebViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
