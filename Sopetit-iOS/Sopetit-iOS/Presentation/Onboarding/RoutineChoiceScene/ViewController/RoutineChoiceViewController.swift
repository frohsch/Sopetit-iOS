//
//  RoutineChoiceViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

final class RoutineChoiceViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedTheme: [Int] = []
    var userDollName: String = ""
    private var selectedCount: Int = 0
    private var selectedRoutine: [Int] = []
    private var routineEntity: [[Routine]] = Array(repeating: [], count: 3)
    private var dollEntity = DollImageEntity(faceImageURL: "")
    
    // MARK: - UI Components
    
    private let routineChoiceView = RoutineChoiceView()
    private lazy var themeCollectionView = routineChoiceView.themeCollectionView
    private lazy var routineFirstCollectionView = routineChoiceView.routineFirstCollectionView
    private lazy var routineSecondCollectionView = routineChoiceView.routineSecondCollectionView
    private lazy var routineThirdCollectionView = routineChoiceView.routineThirdCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = routineChoiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
        getRoutineAPI()
        getDollAPI()
    }
}

// MARK: - Extensions

extension RoutineChoiceViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        routineChoiceView.navigationView.delegate = self
        
        let collectionViews : [UICollectionView] = [themeCollectionView, routineFirstCollectionView, routineSecondCollectionView, routineThirdCollectionView]
        collectionViews.forEach {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func setAddTarget() {
        routineChoiceView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        let nav = TabBarController()
        postMemberAPI()
        UserManager.shared.hasPostMember()
        keyWindow.rootViewController = UINavigationController(rootViewController: nav)
    }
    
    func setCollectionView(idx: Int) {
        switch idx {
        case 0:
            routineFirstCollectionView.isHidden = false
            routineSecondCollectionView.isHidden = true
            routineThirdCollectionView.isHidden = true
        case 1:
            routineFirstCollectionView.isHidden = true
            routineSecondCollectionView.isHidden = false
            routineThirdCollectionView.isHidden = true
        case 2:
            routineFirstCollectionView.isHidden = true
            routineSecondCollectionView.isHidden = true
            routineThirdCollectionView.isHidden = false
        default:
            break
        }
    }
}

extension RoutineChoiceViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Network

extension RoutineChoiceViewController {
    func getRoutineAPI() {
        let orderArray = [1, 4, 6, 7, 2, 10, 3]
        let orderDict = Dictionary(uniqueKeysWithValues: orderArray.enumerated().map { ($1, $0) })
        selectedTheme.sort { (a, b) -> Bool in
            let orderA = orderDict[a] ?? Int.max
            let orderB = orderDict[b] ?? Int.max
            return orderA < orderB
        }
        let routineID = selectedTheme.map { String($0) }.joined(separator: ",")
        
        OnBoardingService.shared.getOnboardingRoutineAPI(routineID: routineID) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<RoutineChoiceEntity> {
                    if let listData = data.data {
                        DispatchQueue.main.async {
                            for i in 0...2 {
                                self.routineEntity[i] = listData.themes[i].routines
                            }
                            self.routineFirstCollectionView.reloadData()
                            self.routineSecondCollectionView.reloadData()
                            self.routineThirdCollectionView.reloadData()
                        }
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func getDollAPI() {
        OnBoardingService.shared.getOnboardingDollAPI(dollType: UserManager.shared.getDollType) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DollImageEntity> {
                    if let listData = data.data {
                        self.dollEntity = listData
                    }
                    self.routineChoiceView.setDataBind(model: self.dollEntity)
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func postMemberAPI() {
        OnBoardingService.shared.postOnboardingMemeberAPI(dollType: UserManager.shared.getDollType, dollName: self.userDollName, routineArray: selectedRoutine) { networkResult in
            switch networkResult {
            case .success:
                print("success")
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.postMemberAPI()
                    } else {
                        self.makeSessionExpiredAlert()
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

extension RoutineChoiceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case themeCollectionView:
            if let cell = collectionView.cellForItem(at: indexPath) as? RoutineThemeCollectionViewCell {
                cell.backgroundColor = .SoftieWhite
                cell.routineThemeLabel.textColor = .Gray700
            }
            self.setCollectionView(idx: indexPath.item)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
        case themeCollectionView:
            if let cell = collectionView.cellForItem(at: indexPath) as? RoutineThemeCollectionViewCell {
                cell.backgroundColor = .clear
                cell.routineThemeLabel.textColor = .Gray500
            }
        default:
            break
        }
    }
}

extension RoutineChoiceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case themeCollectionView:
            let cell = RoutineThemeCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(themeID: selectedTheme[indexPath.item])
            if indexPath.item == 0 {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                cell.backgroundColor = .SoftieWhite
                cell.routineThemeLabel.textColor = .Gray700
            } else {
                cell.backgroundColor = .clear
                cell.routineThemeLabel.textColor = .Gray500
            }
            return cell
        case routineFirstCollectionView:
            let cell = RoutineChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: routineEntity[0][indexPath.item])
            return cell
        case routineSecondCollectionView:
            let cell = RoutineChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: routineEntity[1][indexPath.item])
            return cell
        case routineThirdCollectionView:
            let cell = RoutineChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: routineEntity[2][indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case themeCollectionView:
            return 3
        case routineFirstCollectionView:
            return routineEntity[0].count
        case routineSecondCollectionView:
            return routineEntity[1].count
        case routineThirdCollectionView:
            return routineEntity[2].count
        default:
            return 0
        }
    }
}
