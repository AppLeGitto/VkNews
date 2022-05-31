//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 30.05.2022.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelframe: CGRect
    var attechmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 13, bottom: 13, right: 13)
    static let topViewHeight: CGFloat = 38
    static let bottomViewHeight: CGFloat = 38
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 12, bottom: 12, right: 12)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
}


protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: Work with postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let postText = postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = postText.height(width: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Work with attachmentFrame
        
        let attachmentTop = postLabelFrame.size == .zero ? Constants.postLabelInsets.top : Constants.postLabelInsets.bottom + postLabelFrame.maxY
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: attachmentTop),
                                     size: CGSize.zero)

        if let photoAttachment = photoAttachment {
            let ratio = CGFloat(photoAttachment.height) / CGFloat(photoAttachment.width)

            let width = cardViewWidth
            let height = width * ratio
            
            attachmentFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Work with bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY) + 5

        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        //MARK: Work with totalHeight

        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        return Sizes(postLabelframe: postLabelFrame,
                     attechmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
}
