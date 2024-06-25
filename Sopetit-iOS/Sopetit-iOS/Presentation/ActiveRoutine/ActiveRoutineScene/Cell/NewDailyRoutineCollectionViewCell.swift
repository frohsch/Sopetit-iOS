//
//  newDailyRoutineCollectionViewCell.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

final class NewDailyRoutineCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {

    static let isFromNib: Bool = false
    
    private var index: Int = 0
    
    var isEditing: Bool = false {
        didSet {
            switch isEditing {
            case true:
                radioButton.isHidden = false
                radioButton.setImage(ImageLiterals.DailyRoutine.btnRadiobtnNone, for: .normal)

            case false:
                radioButton.isHidden = true
            }
        }
    }
    
    weak var delegate: ConfirmDelegate?
    weak var radioDelegate: RadioButtonDelegate?
    
    // MARK: - UI Components
    
    private let routineView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body1)
        label.textColor = .Gray700
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var radioButton: CustomButton = {
        let button = CustomButton()
        button.setImage(ImageLiterals.ActiveRoutine.checkEmpty, for: .normal)
        return button
    }()
    
    private let routineLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = .Gray700
        label.numberOfLines = 0
        return label
    }()
    
    let ellipsisButton: CustomButton = {
        let button = CustomButton()
        button.setImage(ImageLiterals.ActiveRoutine.icnMore, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        radioButton.isHidden = true
        radioButton.setImage(ImageLiterals.DailyRoutine.btnRadiobtnNone, for: .normal)
    }
    
}

private extension NewDailyRoutineCollectionViewCell {
    
    func setUI() {
        self.backgroundColor = .SoftieWhite
        self.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMaxYCorner])
        self.layer.borderColor = UIColor.Gray200.cgColor
        self.layer.borderWidth = 1
    }
    
    func setHierarchy() {
        self.addSubviews(radioButton, routineLabel, ellipsisButton)
    }
    
    func setLayout() {
        radioButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        routineLabel.snp.makeConstraints {
            $0.leading.equalTo(radioButton.snp.trailing).offset(8)
            $0.trailing.equalTo(ellipsisButton.snp.leading).offset(-23)
            $0.centerY.equalToSuperview()
        }
        
        ellipsisButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
    }

    func setAddTarget() {
        radioButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ellipsisButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc
    func tapButton(_ sender: UIButton) {
        switch sender {
        case radioButton:
            print("radioButton tapped")
        case ellipsisButton:
            print("ellipsisButton tapped")
        default:
            break
        }
    }
}

extension NewDailyRoutineCollectionViewCell {
    
    func setDataBind(text: String) {
        routineLabel.text = text
        routineLabel.setTextWithLineHeight(text: text, lineHeight: 20)
    }
}
