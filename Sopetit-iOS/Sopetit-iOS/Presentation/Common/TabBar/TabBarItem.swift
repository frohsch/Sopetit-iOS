//
//  TabBarItem.swift
//
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case ongoing
    case home
    case achieve
}

extension TabBarItemType {
    
    var unSelectedIcon: UIImage {
        switch self {
        case .ongoing:
            return UIImage(resource: .icNavi1)
        case .home:
            return UIImage(resource: .icNavi2)
        case .achieve:
            return UIImage(resource: .icNavi3)
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .ongoing:
            return UIImage(resource: .icNavi1Filled)
        case .home:
            return UIImage(resource: .icNavi2Filled)
        case .achieve:
            return UIImage(resource: .icNavi3Filled)
        }
    }
    
    func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "", image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
