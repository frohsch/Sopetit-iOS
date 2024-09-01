//
//  RoutineChoiceCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit

final class RoutineChoiceCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties

    static let isFromNib: Bool = false
    
    override var isSelected: Bool {
        didSet {
            routineChoiceButton.image = UIImage(resource: isSelected ? .btnCheck : .btnAdd)
        }
    }
    
    var hasRoutine: Bool = false {
        didSet {
            self.backgroundColor = hasRoutine ? .Gray200 : .SoftieWhite
            self.layer.borderColor = hasRoutine ? UIColor.Gray300.cgColor : UIColor.Gray200.cgColor
            routineLabel.textColor = hasRoutine ? .Gray400 : .Gray700
            routineChoiceButton.isHidden = hasRoutine ? true : false
        }
    }
    
    // MARK: - UI Components
    
    let routineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let routineChoiceButton = UIImageView(image: UIImage(resource: .btnAdd))
    
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
        
        self.isSelected = false
    }
}

// MARK: - Extensions

extension RoutineChoiceCollectionViewCell {
    
    func setUI() {
        self.backgroundColor = .SoftieWhite
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.Gray200.cgColor
        self.layer.borderWidth = 1
    }

    func setHierarchy() {
        addSubviews(routineLabel, routineChoiceButton)
    }
    
    func setLayout() {
        routineLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        routineChoiceButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
    }
    
    func setDataBind(model: Routine) {
        routineLabel.text = model.content
        routineLabel.asLineHeight(.body2)
    }
    
    func setAddRoutineBind(model: Routines) {
        routineLabel.text = model.content
    }
}
