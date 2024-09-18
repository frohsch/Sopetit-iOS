//
//  OngoingView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

import SnapKit

protocol ChallengeInfoProtocol: AnyObject {
    func tapChallengeInfoButton()
}

class OngoingView: UIView {
    
    weak var delegate: ChallengeInfoProtocol?

    var isChallenge: Bool = false {
        willSet(status) {
            setRoutineView(challenge: status, daily: isDaily)
        }
    }
    
    var isDaily: Bool = false {
        willSet(status) {
            setRoutineView(challenge: isChallenge, daily: status)
        }
    }
    
    private let dateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head3)
        label.textColor = .Gray700
        return label
    }()
    
    let routineEmptyView = RoutineEmptyView()
    let challengeRoutineEmptyView = ChallengeRoutineEmptyView()
    let challengeRoutineView = ChallengeRoutineView()
    
    let divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        return view
    }()
    
    let dailyRoutineEmptyView = DailyRoutineEmptyView()
    let dailyRoutineView = NewDailyRoutineView()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.ActiveRoutine.icnAddButton, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
    
    let cancelToastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastCancel
        return imageView
    }()
    
    let notCottonToastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastNotCotton
        return imageView
    }()
    
    let deleteToastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastDelete
        return imageView
    }()
    
    let dailyInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray950
        return view
    }()
    
    let dailyInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.popover
        return imageView
    }()
    
    let challengeInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.popoverChallenge
        return imageView
    }()
    
    let deleteToastChallengeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.toastChallengeDelete
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
        setDateLabel()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OngoingView {
    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        self.addSubviews(dateView, scrollView)
        dateView.addSubview(dateLabel)
    }
    
    func setLayout() {
        dateView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func setDateLabel() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        let formattedDate = dateFormatter.string(from: currentDate)
        dateLabel.text = formattedDate
    }
    
    func setAddTarget() {
        challengeRoutineView.challengeInfoButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        delegate?.tapChallengeInfoButton()
    }
}

extension OngoingView {
    
    func setRoutineView(challenge: Bool, daily: Bool) {
        if challenge == false && daily == false {
            self.scrollView.subviews.forEach { $0.removeFromSuperview() }
        }
        
        else {
            self.scrollView.addSubview(divisionView)
            if challenge == true {
                challengeRoutineEmptyView.removeFromSuperview()
                scrollView.addSubview(challengeRoutineView)
                challengeRoutineView.snp.makeConstraints {
                    $0.top.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(198)
                }
                
                divisionView.snp.makeConstraints {
                    $0.top.equalTo(challengeRoutineView.snp.bottom)
                    $0.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(2)
                }
            }
            else {
                challengeRoutineView.removeFromSuperview()
                scrollView.addSubview(challengeRoutineEmptyView)
                challengeRoutineEmptyView.snp.makeConstraints {
                    $0.top.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(140)
                }
                
                divisionView.snp.makeConstraints {
                    $0.top.equalTo(challengeRoutineEmptyView.snp.bottom)
                    $0.horizontalEdges.equalToSuperview()
                    $0.height.equalTo(2)
                }
            }
            
            if daily == true {
                dailyRoutineEmptyView.removeFromSuperview()
                scrollView.addSubview(dailyRoutineView)
                dailyRoutineView.snp.makeConstraints {
                    $0.top.equalTo(divisionView)
                    $0.horizontalEdges.bottom.equalToSuperview()
                }
            }
            else {
                dailyRoutineView.removeFromSuperview()
                scrollView.addSubview(dailyRoutineEmptyView)
                dailyRoutineEmptyView.snp.makeConstraints {
                    $0.top.equalTo(divisionView)
                    $0.horizontalEdges.bottom.equalToSuperview()
                }
            }
        }
    }
}
