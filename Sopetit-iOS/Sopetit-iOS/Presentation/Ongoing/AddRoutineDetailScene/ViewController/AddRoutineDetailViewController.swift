//
//  AddRoutineDetailViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/12/24.
//

import UIKit

import SnapKit

final class AddRoutineDetailViewController: UIViewController {
    
    private var dailyThemeEntity = DailyThemeEntity(routines: [])
    private var challengeThemeEntity = RoutineChallengeEntity(routines: [])
    var addRoutineInfoEntity = AddRoutineInfoEntity.addRoutineInfoInitial()
    
    // MARK: - UI Components
    
    private lazy var addRoutineDetailView = AddRoutineDetailView(info: addRoutineInfoEntity)
    private lazy var routineDailyCV = addRoutineDetailView.routineDailyCollectionView
    private lazy var challengeCV = addRoutineDetailView.challengeCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addRoutineDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddGesture()
    }
}

// MARK: - Extensions

extension AddRoutineDetailViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        if addRoutineInfoEntity.themeStyle == .routine {
            getDailyThemeAPI(id: addRoutineInfoEntity.id)
        } else {
            addRoutineDetailView.setMenuSelected(dailyTapped: false)
            getChallengeRoutineAPI(id: addRoutineInfoEntity.id)
        }
    }
    
    func setDelegate() {
        addRoutineDetailView.navigationView.delegate = self
        routineDailyCV.delegate = self
        routineDailyCV.dataSource = self
        challengeCV.delegate = self
        challengeCV.dataSource = self
    }
    
    func setAddGesture() {
        let tapDailyMenu = UITapGestureRecognizer(target: self,
                                                  action: #selector(dailyMenuTapped))
        let tapChallengeMenu = UITapGestureRecognizer(target: self,
                                                      action: #selector(challengeMenuTapped))
        addRoutineDetailView.dailyMenuView.addGestureRecognizer(tapDailyMenu)
        addRoutineDetailView.challengeMenuView.addGestureRecognizer(tapChallengeMenu)
    }
    
    @objc
    func dailyMenuTapped() {
        addRoutineDetailView.setMenuSelected(dailyTapped: true)
    }
    
    @objc
    func challengeMenuTapped() {
        addRoutineDetailView.setMenuSelected(dailyTapped: false)
        getChallengeRoutineAPI(id: addRoutineInfoEntity.id)
    }
}

extension AddRoutineDetailViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Network

extension AddRoutineDetailViewController {
    
    func getDailyThemeAPI(id: Int) {
        AddDailyRoutineService.shared.getDailyRoutine(id: id) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyThemeEntity> {
                    if let listData = data.data {
                        self.dailyThemeEntity = listData
                    }
                }
                self.heightForRoutineContentView(texts: self.dailyThemeEntity.routines)
                self.routineDailyCV.reloadData()
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getDailyThemeAPI(id: self.addRoutineInfoEntity.id)
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            default:
                break
            }
        }
    }
    
    func getChallengeRoutineAPI(id: Int) {
        AddDailyRoutineService.shared.getChallengeRoutine(id: id) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<RoutineChallengeEntity> {
                    if let listData = data.data {
                        self.challengeThemeEntity = listData
                    }
                }
                self.heightForChallengeContentView(numberOfSection: self.challengeThemeEntity.routines.count,
                                                   texts: self.challengeThemeEntity.routines)
                self.challengeCV.reloadData()
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getChallengeRoutineAPI(id: self.addRoutineInfoEntity.id)
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            default:
                break
            }
        }
    }
}

extension AddRoutineDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
        //        switch collectionView {
        //        case routineDailyCV:
        //            return true
        //            return setSelectedCell(in: collectionView, at: indexPath, routineIndex: 0)
        //        default:
        //            return false
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
        //        switch collectionView {
        //        case routineDailyCV:
        //            return setDeselectedCell(in: collectionView, at: indexPath, routineIndex: 0)
        //            return true
        //        default:
        //            return false
        //        }
    }
}

extension AddRoutineDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case challengeCV:
            return challengeThemeEntity.routines.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case routineDailyCV:
            let cell = RoutineChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setAddRoutineBind(model: dailyThemeEntity.routines[indexPath.item])
            return cell
        case challengeCV:
            let cell = AddChallengeRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setRoutineChallengeBind(model: challengeThemeEntity.routines[indexPath.section].challenges[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case routineDailyCV:
            return dailyThemeEntity.routines.count
        case challengeCV:
            return challengeThemeEntity.routines[section].challenges.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch collectionView {
        case challengeCV:
            let headerView = AddChallengeRoutineHeaderView.dequeueReusableHeaderView(collectionView: challengeCV, indexPath: indexPath)
            headerView.setChallengeHeaderBind(headerTitle: challengeThemeEntity.routines[indexPath.section].title)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

extension AddRoutineDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case routineDailyCV:
            return CGSize(width: SizeLiterals.Screen.screenWidth - 40,
                          height: 56)
        case challengeCV:
            let label: UILabel = {
                let label = UILabel()
                label.text = challengeThemeEntity.routines[indexPath.section].challenges[indexPath.item].content.replacingOccurrences(of: "\n", with: " ")
                label.font = .fontGuide(.body2)
                return label
            }()
            label.sizeThatFits(CGSize(width: SizeLiterals.Screen.screenWidth - 80, height: 20))
            let height = heightForView(text: label.text ?? "",
                                       font: label.font,
                                       width: SizeLiterals.Screen.screenWidth - 80) + 94
            return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: height)
        default:
            return CGSize()
        }
    }
    
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                   width: width,
                                                   height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.setTextWithLineHeight(text: label.text, lineHeight: 20)
        label.sizeToFit()
        return label.frame.height
    }
    
    func heightForChallengeContentView(numberOfSection: Int,
                                       texts: [RoutineChallenge]) {
        var height = Double(numberOfSection) * 18.0
        
        for i in texts {
            for j in i.challenges {
                let textHeight = heightForView(text: j.content,
                                               font: .fontGuide(.body2),
                                               width: SizeLiterals.Screen.screenWidth - 80) + 94
                height += textHeight
            }
            height += 44
        }
        height += 108
        
        UIView.animate(withDuration: 0.3) {
            self.addRoutineDetailView.challengeCollectionView.snp.makeConstraints {
                $0.top.equalTo(self.addRoutineDetailView.menuUnderlineView.snp.bottom)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
                $0.height.equalTo(height)
            }
            self.challengeCV.layoutIfNeeded()
        }
    }
    
    func heightForRoutineContentView(texts: [Routines]) {
        var height = Double(1) * 18.0
        
        for i in texts {
            let textHeight = heightForView(text: i.content,
                                           font: .fontGuide(.body2),
                                           width: SizeLiterals.Screen.screenWidth - 80) + 94
            height += textHeight
        }
        
        UIView.animate(withDuration: 0.3) {
            self.addRoutineDetailView.routineDailyCollectionView.snp.makeConstraints {
                $0.top.equalTo(self.addRoutineDetailView.menuUnderlineView.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
                $0.height.equalTo(height)
            }
            self.challengeCV.layoutIfNeeded()
        }
    }
}
