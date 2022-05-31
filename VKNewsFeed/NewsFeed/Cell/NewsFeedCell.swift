//
//  NewsFeedCell.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 24.05.2022.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelframe: CGRect { get }
    var attechmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    
    var width: Int { get }
    var height: Int { get }
}

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
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
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
    
    func set(viewModel: FeedCellViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        
        postLabel.text = viewModel.text
        postLabel.frame = viewModel.sizes.postLabelframe
    
        bottomView.frame = viewModel.sizes.bottomViewFrame
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        
        if let photoAttechment = viewModel.photoAttachment {
            postImageView.set(imageUrl: photoAttechment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        postImageView.frame = viewModel.sizes.attechmentFrame
    }
}
