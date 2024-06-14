//
//  FontLiterals.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import UIKit

enum FontName: String {
    case PretendardMedium = "Pretendard-Medium"
    case PretendardSemiBold = "Pretendard-SemiBold"
    case OmyuPretty = "omyu_pretty"
}

enum FontLevel {
    case head1
    case head2
    case head3
    case head4
    
    case body1
    case body2
    
    case caption1
    case caption2
    
    case bubble1
    case bubble2
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .head1, .head2, .head3, .head4:
            return FontName.PretendardSemiBold.rawValue
        case .body1, .body2, .caption1, .caption2:
            return FontName.PretendardMedium.rawValue
        case .bubble1, .bubble2:
            return FontName.OmyuPretty.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .head1:
            return 20
        case .head2, .bubble1:
            return 18
        case .head3, .body1, .bubble2:
            return 16
        case .head4, .body2:
            return 14
        case .caption1:
            return 12
        case .caption2:
            return 10
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .head1:
            return 56
        case .head2:
            return 28
        case .head3, .body1:
            return 24
        case .head4, .body2:
            return 20
        case .caption1:
            return 18
        case .caption2:
            return 12
        default:
            return 0
        }
    }
}

extension UIFont {
    static func fontGuide(_ fontLevel: FontLevel) -> UIFont {
        let font = UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
        return font
    }
}
