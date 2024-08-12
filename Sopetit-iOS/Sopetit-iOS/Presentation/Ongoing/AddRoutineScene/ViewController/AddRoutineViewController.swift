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
    private lazy var makerCollectionView = addRoutineView.makerCollectionView
    private lazy var routineCollectionView = addRoutineView.totalRoutineCollectionView
    private var makersEntity = MakersEntity.makersInitialEntity()
    private var routineEntity = ThemeSelectEntity(themes: [])
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        getMakersAPI()
        getThemeAPI()
    }
}

// MARK: - Extensions

extension AddRoutineViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        makerCollectionView.delegate = self
        makerCollectionView.dataSource = self
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
    }
}

// MARK: - Network

extension AddRoutineViewController {
    
    func getMakersAPI() {
        AddDailyRoutineService.shared.getMakers { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<MakersEntity> {
                    if let listData = data.data {
                        self.makersEntity = listData
                    }
                }
                self.makerCollectionView.reloadData()
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getMakersAPI()
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            default:
                break
            }
        }
    }
    
    func getThemeAPI() {
        OnBoardingService.shared.getOnboardingThemeAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ThemeSelectEntity> {
                    if let listData = data.data {
                        self.routineEntity = listData
                    }
                    self.routineCollectionView.reloadData()
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getThemeAPI()
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

extension AddRoutineViewController: UICollectionViewDelegate {
    
}

extension AddRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case makerCollectionView:
            return makersEntity.makers.count
        case routineCollectionView:
            return routineEntity.themes.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case makerCollectionView:
            let cell = MakersCollectionViewCell.dequeueReusableCell(collectionView: makerCollectionView, indexPath: indexPath)
            cell.setDataBind(model: makersEntity.makers[indexPath.item])
            cell.makerChipCollectionView.reloadData()
            return cell
        case routineCollectionView:
            let cell = TotalRoutineCollectionViewCell.dequeueReusableCell(collectionView: routineCollectionView, indexPath: indexPath)
            cell.setDataBind(model: routineEntity.themes[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
