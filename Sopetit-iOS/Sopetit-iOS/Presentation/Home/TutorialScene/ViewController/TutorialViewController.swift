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
        collectionView.delegate = self
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

extension TutorialViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SizeLiterals.Screen.screenWidth * 320 / 375, height: 385)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, 
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: CGFloat
        
        if velocity.x > 0 {
            index = ceil(estimatedIndex)
        } else if velocity.x < 0 {
            index = floor(estimatedIndex)
        } else {
            index = round(estimatedIndex)
        }
        
        let newOffsetX = index * cellWidthIncludingSpacing
        targetContentOffset.pointee = CGPoint(x: newOffsetX, y: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        tutorialView.pageControl.currentPage = currentPage
    }
}
