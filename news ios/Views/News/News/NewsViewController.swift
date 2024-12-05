//
//  NewsViewController.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

class NewsViewController: UIViewController {

	@IBOutlet weak var colView: UICollectionView!
	var viewModel: NewsViewModel = NewsViewModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		fetchNews()
		configureColView()
    }
	
	private func fetchNews() {
		viewModel.fetchNews {
			DispatchQueue.main.async { [weak self] in
				self?.colView.reloadData()
			}
		}
	}
	
	private func configureColView() {
		colView.delegate = self
		colView.dataSource = self
		NewsCollectionViewCell.register(for: colView)
	}
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.newsModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
		let newsItem = viewModel.newsModel[indexPath.item]
		cell.configure(newsItem)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedNews = viewModel.newsModel[indexPath.item]
		
		let vc = DetailNewsViewController.loadFromNib()
		vc.viewModel.selectedNewsModel = selectedNews
		navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.bounds.width - 32
		let height: CGFloat = 166
		
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 16
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}

