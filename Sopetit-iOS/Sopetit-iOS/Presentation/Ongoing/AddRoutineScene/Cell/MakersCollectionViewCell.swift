//
//  MakersCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/11/24.
//

import UIKit

import SnapKit

final class MakersCollectionViewCell: UICollectionViewCell, 
                                        UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let makerProfileImage = UIImageView(image: .checkmark)
    
    private let makerGoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icNext), for: .normal)
        return button
    }()
    
    private let makerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "200만 유튜버와 함께하는"
        label.textColor = .Gray500
        label.font = .fontGuide(.caption1)
        label.asLineHeight(.caption1)
        return label
    }()
    
    private let makerContentLabel: UILabel = {
        let label = UILabel()
        label.text = "유튜버가 되기위한 1일1루틴"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
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

private extension MakersCollectionViewCell {

    func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.Gray200.cgColor
    }
    
    func setHierarchy() {
        addSubviews(makerProfileImage,
                    makerGoButton,
                    makerDescriptionLabel,
                    makerContentLabel)
    }
    
    func setLayout() {
        makerProfileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(54)
        }
        
        makerGoButton.snp.makeConstraints {
            $0.top.equalTo(makerProfileImage.snp.top)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(24)
        }
        
        makerDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(makerProfileImage.snp.bottom).offset(12)
            $0.leading.equalTo(makerProfileImage.snp.leading)
        }
        
        makerContentLabel.snp.makeConstraints {
            $0.top.equalTo(makerDescriptionLabel.snp.bottom).offset(2)
            $0.leading.equalTo(makerProfileImage.snp.leading)
        }
    }
}

extension MakersCollectionViewCell {
    
    func setDataBind(model: Maker) {
        makerProfileImage.kfSetImage(url: model.profileImageURL)
        makerDescriptionLabel.text = model.description
        makerContentLabel.text = model.content
    }
}
