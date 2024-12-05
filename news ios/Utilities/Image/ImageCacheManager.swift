//
//  ImageCacheManager.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

class ImageCacheManager {
	static let shared = ImageCacheManager()
	private let cache = NSCache<NSString, UIImage>()

	private init() {}

	/// Retrieve an image from the cache
	func getImage(forKey key: String) -> UIImage? {
		return cache.object(forKey: key as NSString)
	}

	/// Save an image to the cache
	func saveImage(_ image: UIImage, forKey key: String) {
		cache.setObject(image, forKey: key as NSString)
	}
}
