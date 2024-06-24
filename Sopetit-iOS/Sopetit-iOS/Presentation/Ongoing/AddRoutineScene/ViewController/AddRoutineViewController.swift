//
//  AddRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/27/24.
//

import UIKit

import SnapKit

final class AddRoutineViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var addRoutineView = AddRoutineView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: - Extensions

extension AddRoutineViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
