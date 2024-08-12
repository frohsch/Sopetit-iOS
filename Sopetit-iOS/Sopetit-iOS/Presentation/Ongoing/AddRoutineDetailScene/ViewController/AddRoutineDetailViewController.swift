//
//  AddRoutineDetailViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/12/24.
//

import UIKit

import SnapKit

enum AddRoutineTheme {
    case routine
    case maker
}

final class AddRoutineDetailViewController: UIViewController {
    
    var theme: AddRoutineTheme?
    var id: Int = 0
    private var dailyThemeEntity = DailyThemeEntity(routines: [])
    
    // MARK: - UI Components
    
    private lazy var addRoutineDetailView = AddRoutineDetailView(theme: theme ?? .routine)
    private lazy var routineDailyCV = addRoutineDetailView.routineDailyCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addRoutineDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        getDailyThemeAPI(id: self.id)
    }
}

// MARK: - Extensions

extension AddRoutineDetailViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        addRoutineDetailView.navigationView.delegate = self
        routineDailyCV.delegate = self
        routineDailyCV.dataSource = self
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
        print("🔥🔥🔥")
        print(id)
        AddDailyRoutineService.shared.getDailyRoutine(id: id) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyThemeEntity> {
                    if let listData = data.data {
                        self.dailyThemeEntity = listData
                    }
                }
                dump(data)
                self.routineDailyCV.reloadData()
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getDailyThemeAPI(id: self.id)
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
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch collectionView {
        case routineDailyCV:
            return true
//            return setSelectedCell(in: collectionView, at: indexPath, routineIndex: 0)
        default:
            return false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        switch collectionView {
        case routineDailyCV:
//            return setDeselectedCell(in: collectionView, at: indexPath, routineIndex: 0)
            return true
        default:
            return false
        }
    }
}

extension AddRoutineDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case routineDailyCV:
            let cell = RoutineChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setAddRoutineBind(model: dailyThemeEntity.routines[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case routineDailyCV:
            return dailyThemeEntity.routines.count
        default:
            return 0
        }
    }
}
