//
//  NewsService.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import Foundation

class NewsService {
	
	var newsModel: [NewsModel] = []
	
	/// Fetch News
	func fetchNews(completion: @escaping([NewsModel]?, Error?) -> Void) {
		NetworkManager.shared.request(
			url: "/posts",
			method: .GET,
			responseType: [NewsModel].self
		) { result in
			switch result {
			case .success(let news):
				self.newsModel = news
				completion(self.newsModel, nil)
				
			case .failure(let error):
				print("Error: \(error)")
				completion(nil, error)
			}
		}
	}
	
}
