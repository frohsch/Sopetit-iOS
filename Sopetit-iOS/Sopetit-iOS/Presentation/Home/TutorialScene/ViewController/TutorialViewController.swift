//
//  TutorialViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/3/24.
//

import UIKit

import SnapKit

final class TutorialViewController: UIViewController {

    // MARK: - UI Components
    
    private var tutorialView = TutorialView()
    private lazy var collectionView = tutorialView.tutorialCollectionView
    private let tutorialData = HomeTutorialEntity.tutorialData()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = tutorialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension TutorialViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        collectionView.dataSource = self
    }
}

// MARK: - CollectionView

extension TutorialViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorialData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TutorialCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDataBind(model: tutorialData[indexPath.item])
        return cell
    }
}
