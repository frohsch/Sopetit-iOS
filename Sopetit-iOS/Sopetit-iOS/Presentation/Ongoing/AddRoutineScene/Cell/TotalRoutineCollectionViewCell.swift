//
//  TotalRoutineCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/12/24.
//

import UIKit

import SnapKit

final class TotalRoutineCollectionViewCell: UICollectionViewCell,
                                        UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let routineImage = UIImageView()
    
    private let routineSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.caption2)
        label.asLineHeight(.caption2)
        return label
    }()
    
    private let routineTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    private let routineDetailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icNext), for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension TotalRoutineCollectionViewCell {

    func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.Gray200.cgColor
    }
    
    func setHierarchy() {
        addSubviews(routineImage,
                    routineSubTitleLabel,
                    routineTitleLabel,
                    routineDetailButton)
    }
    
    func setLayout() {
        routineImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        routineSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(routineImage.snp.top)
            $0.leading.equalTo(routineImage.snp.trailing).offset(12)
        }
        
        routineTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(routineImage.snp.bottom)
            $0.leading.equalTo(routineImage.snp.trailing).offset(12)
        }
        
        routineDetailButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
}

extension TotalRoutineCollectionViewCell {
    
    func setDataBind(model: Theme) {
        routineTitleLabel.text = model.title
        routineTitleLabel.asLineHeight(.head3)
        routineSubTitleLabel.text = model.subTitle
        routineSubTitleLabel.asLineHeight(.caption2)
        routineImage.image = {
            switch model.themeID {
            case 1:
                return UIImage(resource: .theme1)
            case 2:
                return UIImage(resource: .theme5)
            case 3:
                return UIImage(resource: .theme7)
            case 4:
                return UIImage(resource: .theme2)
            case 5:
                return UIImage(resource: .theme6)
            case 6:
                return UIImage(resource: .theme3)
            case 7:
                return UIImage(resource: .theme4)
            default:
                return UIImage()
            }
        }()
    }
}
