//
//  ActiveRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

class OngoingViewController: UIViewController {
    
    private var challengeRoutine = ChallengeRoutine(routineId: 0, themeId: 0, themeName: "", title: "", content: "", detailContent: "", place: "", timeTaken: "")
    private var dailyRoutineEntity = NewDailyRoutineEntity(routines: [])
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
        setAddTarget()
        getDailyRoutine()
        getChallengeRoutine()
    }
}

private extension OngoingViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        heightForContentView(numberOfSection: dailyRoutineEntity.routines.count, texts: dailyRoutineEntity)
    }
    
    @objc
    func buttonTapped() {
        let nav = AddRoutineViewController()
        nav.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nav, animated: true)
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
        if challengeRoutine.themeId == 0 {
            ongoingView.setChallengeRoutineEmpty()
        }
    }
    
    func setAddTarget() {
        ongoingView.routineEmptyView.addRoutineButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ongoingView.challengeInfoButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ongoingView.dailyInfoButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ongoingView.floatingButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton(_ sender: UIButton) {
        switch sender {
        case ongoingView.routineEmptyView.addRoutineButton:
            print("addRoutineButton tapped")
            let vc = AddRoutineViewController()
            self.present(vc, animated: true)
        case ongoingView.challengeInfoButton:
            print("challengeInfoButton tapped")
        case ongoingView.dailyInfoButton:
            print("dailyInfoButton tapped")
        case ongoingView.floatingButton:
            print("floatingButton tapped")
            let vc = AddRoutineViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

extension OngoingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if dailyRoutineEntity.routines.isEmpty {
            print("EEEEEEEEEEEE")
            ongoingView.setEmptyView()
        }
        return dailyRoutineEntity.routines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dailyRoutineEntity.routines[section].routines.count, "⬆️⬆️⬆️⬆️⬆️")
        return dailyRoutineEntity.routines[section].routines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = NewDailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDataBind(routine: dailyRoutineEntity.routines[indexPath.section].routines[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = NewDailyRoutineHeaderView.dequeueReusableHeaderView(collectionView: ongoingView.dailyCollectionView, indexPath: indexPath)
            headerView.setDataBind(text: dailyRoutineEntity.routines[indexPath.section].themeName, image: dailyRoutineEntity.routines[indexPath.section].themeId)
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension OngoingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label: UILabel = {
            let label = UILabel()
            label.text = dailyRoutineEntity.routines[indexPath.section].routines[indexPath.item].content
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
    
    func heightForContentView(numberOfSection: Int, texts: NewDailyRoutineEntity) {
        var height = Double(numberOfSection) * 18.0
        
        for i in texts.routines {
            for j in i.routines {
                let textHeight = heightForView(text: j.content, font: .fontGuide(.body2), width: SizeLiterals.Screen.screenWidth - 151) + 36
                height += textHeight
            }
            height += 18
        }
        height += Double(16 * (texts.routines.count - 1) + 54)
        
        ongoingView.dailyCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
}

extension OngoingViewController {
    func getDailyRoutine() {
        DailyRoutineService.shared.getDailyRoutine { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<NewDailyRoutineEntity> {
                    if let listData = data.data {
                        self.dailyRoutineEntity = listData
                    }
                    if self.dailyRoutineEntity.routines.isEmpty {
                        self.ongoingView.setEmptyView()
                    } else {
                        self.ongoingView.setDailyRoutine()
                        self.heightForContentView(numberOfSection: self.dailyRoutineEntity.routines.count, texts: self.dailyRoutineEntity)
                        self.ongoingView.dailyCollectionView.reloadData()
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func getChallengeRoutine() {
        DailyRoutineService.shared.getChallengeRoutine { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ChallengeRoutine> {
                    print(data)
                    if let listData = data.data {
                        self.challengeRoutine = listData
                    }
                    if self.challengeRoutine.themeId == 0 {
                        self.ongoingView.setChallengeRoutineEmpty()
                    } else {
                        self.ongoingView.setChallengeRoutine(routine: self.challengeRoutine)
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}

extension OngoingViewController {
    
    func getCottonView() {
        let vc = GetCottonViewController()
        self.present(vc, animated: false)
    }
}

extension OngoingViewController: CVCellDelegate {
    func selectedRadioButton(_ index: Int) {
        print("did Daily Routine")
        getCottonView()
    }
}
