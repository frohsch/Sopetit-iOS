//
//  CustomButton.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/25/24.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        let touchArea = bounds.insetBy(dx: -9, dy: -9)
        return touchArea.contains(point)
    }

    func configure() {}
    func bind() {}
}
