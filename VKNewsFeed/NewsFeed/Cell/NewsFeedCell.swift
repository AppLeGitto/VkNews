//
//  NewsFeedCell.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 24.05.2022.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var iconImageView: WebImageView!
    @IBOutlet var postImageView: WebImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var sharesLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    @IBOutlet var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let _ = iconImageView {
            iconImageView.layer.cornerRadius = iconImageView.frame.width/2
            iconImageView.clipsToBounds = true
            
            cardView.layer.cornerRadius = 10
            cardView.clipsToBounds = true
            
            backgroundColor = .clear
            selectionStyle = .none
        }
    }
    
//    func set(viewModel: FeedCellViewModel) {
//        nameLabel.text = viewModel.name
//        dateLabel.text = viewModel.date
//
//        postLabel.text = viewModel.text
//        postLabel.frame = viewModel.sizes.postLabelframe
//
//        bottomView.frame = viewModel.sizes.bottomViewFrame
//        likesLabel.text = viewModel.likes
//        commentsLabel.text = viewModel.comments
//        sharesLabel.text = viewModel.shares
//        viewsLabel.text = viewModel.views
//        iconImageView.set(imageUrl: viewModel.iconUrlString)
//
//        if let photoAttechment = viewModel.photoAttachment {
//            postImageView.set(imageUrl: photoAttechment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//        postImageView.frame = viewModel.sizes.attechmentFrame
//    }
}
