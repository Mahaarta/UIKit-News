//
//  NewsCollectionViewCell.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var newsImageView: UIImageView!
	@IBOutlet weak var newsTitleLabel: UILabel!
	@IBOutlet weak var newsContentLabel: UILabel!
	@IBOutlet weak var publishedDateLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		configureLabel()
    }
	
	func configure(_ news: NewsModel) {
		newsTitleLabel.text = news.title
		
		newsContentLabel.text = news.content
		newsContentLabel.numberOfLines = 3
		
		publishedDateLabel.text = news.publishedAt ?? "-"
		
		let placeholderImage = UIImage(named: "placeholder")
		if let thumbnailURL = news.thumbnail {
			newsImageView.loadImage(from: thumbnailURL, placeholder: placeholderImage)
		} else {
			newsImageView.image = placeholderImage
		}
	}

	private func configureImageView() {
		newsImageView.layer.cornerRadius = 12
		newsImageView.clipsToBounds = true
	}
	
	private func configureLabel() {
		newsTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
		newsTitleLabel.textColor = .label
		
		newsContentLabel.font = UIFont.systemFont(ofSize: 12)
		newsContentLabel.textColor = .label
	}
	
}
