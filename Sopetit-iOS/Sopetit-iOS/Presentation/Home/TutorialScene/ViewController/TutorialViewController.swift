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
        setAddTarget()
    }
}

// MARK: - Extensions

extension TutorialViewController {
    
    func setUI() {
        self.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setAddTarget() {
        tutorialView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func nextButtonTapped() {
        let visibleItems = collectionView.indexPathsForVisibleItems
        guard let currentIndexPath = visibleItems.first else { return }
        let nextItem = currentIndexPath.item + 1
        
        if nextItem < tutorialView.pageControl.numberOfPages {
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        } else {
            UserManager.shared.setShowTutorial()
            self.dismiss(animated: false)
        }
    }
    
    func updateNextButtonTitle(currentPage: Int) {
        let totalPages = tutorialView.pageControl.numberOfPages
        
        if currentPage < totalPages - 1 {
            tutorialView.nextButton.setTitle("다음", for: .normal)
        } else {
            tutorialView.nextButton.setTitle("시작하기", for: .normal)
        }
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
        updateNextButtonTitle(currentPage: Int(currentPage))
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let currentPage = tutorialView.pageControl.currentPage
        updateNextButtonTitle(currentPage: currentPage)
    }
}
