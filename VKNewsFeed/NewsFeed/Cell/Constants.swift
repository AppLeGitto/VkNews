//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 31.05.2022.
//
import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 13, bottom: 13, right: 13)
    static let topViewHeight: CGFloat = 38
    static let bottomViewHeight: CGFloat = 38
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 12, bottom: 12, right: 12)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    
    static let bottomViewViewHeight: CGFloat = 38
    static let bottomViewViewWidth: CGFloat = 70
    static let bottomViewViewsIconSize: CGFloat = 24
    
    static let miniFeedPostLimitLines: CGFloat = 8
    static let miniFeedPostLines: CGFloat = 6
    
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
}
