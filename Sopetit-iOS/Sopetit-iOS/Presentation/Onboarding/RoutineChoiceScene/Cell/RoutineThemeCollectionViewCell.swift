//
//  RoutineThemeCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 7/4/24.
//

import UIKit

import SnapKit

final class RoutineThemeCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 2
        stackview.alignment = .center
        return stackview
    }()
    
    private let routineThemeImageView = UIImageView()
    
    let routineThemeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.caption1)
        label.asLineHeight(.caption1)
        label.textAlignment = .center
        return label
    }()
    
    private let routineThemeCount: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .Gray700
        label.font = .fontGuide(.caption1)
        label.asLineHeight(.caption1)
        label.textAlignment = .center
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
        self.backgroundColor = .clear
        routineThemeLabel.textColor = .Gray700
    }
}

// MARK: - Extensions

extension RoutineThemeCollectionViewCell {
    
    func setUI() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
    }

    func setHierarchy() {
        stackview.addArrangedSubviews(routineThemeImageView, routineThemeLabel, routineThemeCount)
        addSubview(stackview)
    }
    
    func setLayout() {
        stackview.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        routineThemeImageView.snp.makeConstraints {
            $0.size.equalTo(16)
        }
    }
    
    func setDataBind(themeID: Int) {
        let themeData = ThemeDetailEntity.getTheme(id: themeID)
        routineThemeLabel.text = themeData.themeTitle
        routineThemeImageView.image = themeData.themeImage
    }
    
    func setCountDataBind(cnt: Int) {
        routineThemeCount.text = cnt < 1 ? "" : String(cnt)
    }
}
