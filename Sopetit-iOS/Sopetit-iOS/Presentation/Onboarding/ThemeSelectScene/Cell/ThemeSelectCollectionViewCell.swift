//
//  ThemeSelectCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit
import SVGKit

final class ThemeSelectCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 6
        stackview.alignment = .center
        return stackview
    }()
    
    var themeIcon = UIImageView()
    
    private let themeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.textAlignment = .center
        label.font = .fontGuide(.body1)
        label.asLineHeight(.body1)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isSelected = false
        self.backgroundColor = .SoftieWhite
        self.layer.borderColor = UIColor.Gray200.cgColor
    }
}

// MARK: - Extensions

extension ThemeSelectCollectionViewCell {
    
    func setUI() {
        backgroundColor = .SoftieWhite
        self.layer.borderColor = UIColor.Gray200.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 24
    }
    
    func setHierarchy() {
        stackview.addArrangedSubviews(themeIcon, themeTitle)
        self.addSubview(stackview)
    }
    
    func setLayout() {
        themeIcon.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        stackview.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setDataBind(model: Theme) {
        themeTitle.text = model.title
        themeIcon.image = {
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
