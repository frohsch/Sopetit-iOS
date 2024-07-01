//
//  ActiveRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

class OngoingViewController: UIViewController {
    
    private let challengeRoutine = ChallengeRoutine.dummy()
    private let dailyRoutine = NewDailyRoutineEntity.dummy()
    let ongoingView = OngoingView()
    
    override func loadView() {
        self.view = ongoingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setRegister()
        setData()
    }
}

private extension OngoingViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        heightForContentView(numberOfSection: dailyRoutine.count, texts: dailyRoutine)
    }
    
    func setDelegate() {
        ongoingView.dailyCollectionView.delegate = self
        ongoingView.dailyCollectionView.dataSource = self
    }
    
    func setRegister() {
        NewDailyRoutineCollectionViewCell.register(target: ongoingView.dailyCollectionView)
        NewDailyRoutineHeaderView.register(target: ongoingView.dailyCollectionView)
    }
    
    func setData() {
        if challengeRoutine.theme == "" || challengeRoutine.theme.isEmpty {
            ongoingView.setChallengeRoutineEmpty()
        }
    }
}

extension OngoingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dailyRoutine.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dailyRoutine[section].routines.count)
        return dailyRoutine[section].routines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = NewDailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDataBind(text: dailyRoutine[indexPath.section].routines[indexPath.item].routine)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = NewDailyRoutineHeaderView.dequeueReusableHeaderView(collectionView: ongoingView.dailyCollectionView, indexPath: indexPath)
            headerView.setDataBind(text: dailyRoutine[indexPath.section].theme)
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension OngoingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label: UILabel = {
            let label = UILabel()
            label.text = dailyRoutine[indexPath.section].routines[indexPath.item].routine
            label.font = .fontGuide(.body2)
            return label
        }()
        label.sizeThatFits(CGSize(width: SizeLiterals.Screen.screenWidth - 151, height: 20))
        let height = max(heightForView(text: label.text ?? "", font: label.font, width: SizeLiterals.Screen.screenWidth - 151), 24) + 32
        print(height)
        
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: height)
    }
    
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.setTextWithLineHeight(text: label.text, lineHeight: 20)
        label.sizeToFit()
        return label.frame.height
    }
    
    func heightForContentView(numberOfSection: Int, texts: [NewDailyRoutineEntity]) {
        var height = Double(numberOfSection) * 18.0
        
        for i in texts {
            for j in i.routines {
                let textHeight = heightForView(text: j.routine, font: .fontGuide(.body2), width: SizeLiterals.Screen.screenWidth - 151) + 36
                height += textHeight
            }
            height += 18
        }
        height += Double(16 * (texts.count - 1) + 54)
        
        ongoingView.dailyCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
}
