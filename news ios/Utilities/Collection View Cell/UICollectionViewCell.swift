//
//  UICollectionViewCell.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

extension UICollectionViewCell {
	
	static func register(for collectionView: UICollectionView)  {
		let cellName = String(describing: self)
		let cellIdentifier = cellName
		let cellNib = UINib(nibName: String(describing: self), bundle: nil)
		collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
	}
	
}
