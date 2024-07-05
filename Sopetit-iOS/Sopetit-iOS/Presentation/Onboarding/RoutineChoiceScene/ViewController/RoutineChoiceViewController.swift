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
    private var routineEntity: [Routine] = []
    private var dollEntity = DollImageEntity(faceImageURL: "")
    
    // MARK: - UI Components
    
    private let routineChoiceView = RoutineChoiceView()
    private lazy var themeCollectionView = routineChoiceView.themeCollectionView
    
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
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self
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
                        dump(listData)
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
        if let cell = collectionView.cellForItem(at: indexPath) as? RoutineThemeCollectionViewCell {
            cell.backgroundColor = .SoftieWhite
            cell.routineThemeLabel.textColor = .Gray700
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? RoutineThemeCollectionViewCell {
            cell.backgroundColor = .clear
            cell.routineThemeLabel.textColor = .Gray500
        }
    }
}

extension RoutineChoiceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}
