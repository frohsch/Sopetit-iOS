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
    private lazy var collectionView = addRoutineView.makerCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension AddRoutineViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension AddRoutineViewController: UICollectionViewDelegate {
    
}

extension AddRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MakersCollectionViewCell.dequeueReusableCell(collectionView: collectionView,
                                                                indexPath: indexPath)
        return cell
    }
}
