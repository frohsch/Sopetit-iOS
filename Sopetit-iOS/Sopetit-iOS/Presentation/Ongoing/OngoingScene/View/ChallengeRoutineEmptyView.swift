//
//  ChallengeRoutineEmptyView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

import SnapKit

protocol AddRoutineProtocol: AnyObject {
    func tapAddChallengeRoutine()
}

class ChallengeRoutineEmptyView: UIView {
    
    weak var delegate: AddRoutineProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.ActiveRoutine.addChallenge
        label.font = .fontGuide(.body2)
        label.textColor = .Gray500
        label.textAlignment = .center
        return label
    }()
    
    let addRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.ActiveRoutine.addChallengeButton, for: .normal)
        button.setTitleColor(.Gray500, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption1)
        button.makeRoundBorder(cornerRadius: 17, borderWidth: 1, borderColor: .Gray400)
        button.backgroundColor = .Gray200
        return button
    }()
    
    let bearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.ActiveRoutine.emptychallenge
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChallengeRoutineEmptyView {
    
    func setUI() {
    }
    
    func setHierarchy() {
        self.addSubviews(titleLabel, addRoutineButton, bearImageView)
    }
    
    func setLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview()
        }
        
        addRoutineButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(92)
            $0.height.equalTo(36)
        }
        
        bearImageView.snp.makeConstraints {
            $0.top.equalTo(addRoutineButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(78)
            $0.height.equalTo(56)
        }
    }
    
    func setAddTarget() {
        addRoutineButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc
    func tapButton(_ sender: UIButton) {
        switch sender {
        case addRoutineButton:
            print("addRoutineButton tapped")
            delegate?.tapAddChallengeRoutine()
        default:
            break
        }
    }
}
