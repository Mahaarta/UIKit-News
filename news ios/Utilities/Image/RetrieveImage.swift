//
//  RetrieveImage.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

extension UIImageView {
	func loadImage(from url: String, placeholder: UIImage? = nil) {
		self.image = placeholder
		
		/// Check if the image is already cached
		if let cachedImage = ImageCacheManager.shared.getImage(forKey: url) {
			self.image = cachedImage
			return
		}
		
		guard let imageURL = URL(string: url) else {
			print("Invalid URL: \(url)")
			return
		}
		
		URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
			if let error = error {
				print("Failed to load image: \(error)")
				return
			}
			
			guard let data = data, let downloadedImage = UIImage(data: data) else {
				print("Failed to decode image data")
				return
			}
			
			/// Cache the downloaded image
			ImageCacheManager.shared.saveImage(downloadedImage, forKey: url)
			
			DispatchQueue.main.async {
				self?.image = downloadedImage
			}
		}.resume()
	}
}
