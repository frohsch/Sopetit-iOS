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
    private var makersEntity = MakersEntity.makersInitialEntity()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        getMakersAPI()
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
}

extension AddRoutineViewController: UICollectionViewDelegate {
    
}

extension AddRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        return makersEntity.makers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MakersCollectionViewCell.dequeueReusableCell(collectionView: collectionView,
                                                                indexPath: indexPath)
        cell.setDataBind(model: makersEntity.makers[indexPath.item])
        return cell
    }
}
