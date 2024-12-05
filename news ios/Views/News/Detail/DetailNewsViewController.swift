//
//  DetailNewsViewController.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

class DetailNewsViewController: UIViewController {

	@IBOutlet weak var newsImageView: UIImageView!
	@IBOutlet weak var newsTitleLabel: UILabel!
	@IBOutlet weak var publishedDateLabel: UILabel!
	@IBOutlet weak var publishedDateTitleLabel: UILabel!
	@IBOutlet weak var newsContentLabel: UILabel!
	
	var viewModel: NewsViewModel = NewsViewModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		configureLabel()
		configureImageView()
    }
	
	private func configureImageView() {
		newsImageView.layer.cornerRadius = 12
		newsImageView.clipsToBounds = true
		newsImageView.contentMode = .scaleAspectFit
	}
	
	private func configureLabel() {
		newsTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		newsTitleLabel.textColor = .label
		newsTitleLabel.numberOfLines = 2
		
		publishedDateLabel.font = UIFont.systemFont(ofSize: 15)
		publishedDateLabel.textColor = .label
		
		publishedDateTitleLabel.font = UIFont.systemFont(ofSize: 12)
		publishedDateTitleLabel.textColor = .label
		
		newsContentLabel.font = UIFont.systemFont(ofSize: 13)
		newsContentLabel.textColor = .label
		
		if let selectedNewsModel = viewModel.selectedNewsModel {
			title = selectedNewsModel.title ?? ""
			
			newsTitleLabel.text = selectedNewsModel.title ?? "-"
			publishedDateLabel.text = selectedNewsModel.publishedAt ?? "-"
			publishedDateTitleLabel.text = "Published date"
			newsContentLabel.text = selectedNewsModel.content ?? "-"
			
			let placeholderImage = UIImage(named: "placeholder")
			if let thumbnailURL = selectedNewsModel.thumbnail {
				newsImageView.loadImage(from: thumbnailURL, placeholder: placeholderImage)
			} else {
				newsImageView.image = placeholderImage
			}
		}
	}
}
