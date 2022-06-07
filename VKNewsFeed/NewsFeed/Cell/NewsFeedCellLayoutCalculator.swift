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
    var moreTextButtonFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButtonFlag = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: Work with postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let postText = postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = postText.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.miniFeedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.miniFeedPostLines
                showMoreTextButtonFlag = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Work with moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButtonFlag == true {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)

        //MARK: Work with attachmentFrame
        
        let attachmentTop = postLabelFrame.size == .zero ? Constants.postLabelInsets.top : Constants.postLabelInsets.bottom + moreTextButtonFrame.maxY
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: attachmentTop),
                                     size: CGSize.zero)
        
        if let photoAttachment = photoAttachments.first {
            let ratio = CGFloat(photoAttachment.height) / CGFloat(photoAttachment.width)
            
            let width = cardViewWidth
            let height = width * ratio
            
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: width, height: height)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: photo.width, height: photo.height)
                    photos.append(photoSize)
                }
                
                let rowHeight = RowLayout.rowHeightCounter(superViewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
        }
        
        //MARK: Work with bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)

        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        //MARK: Work with totalHeight

        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        return Sizes(postLabelframe: postLabelFrame,
                     attechmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     moreTextButtonFrame: moreTextButtonFrame )
    }
}
