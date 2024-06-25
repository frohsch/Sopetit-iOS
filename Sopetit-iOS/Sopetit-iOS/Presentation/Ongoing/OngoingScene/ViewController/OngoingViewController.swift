//
//  OngoingViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/27/24.
//

import UIKit

import SnapKit

final class OngoingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var ongoingView = OngoingView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = ongoingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: - Extensions

extension OngoingViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
