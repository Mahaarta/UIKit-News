//
//  NewsViewModel.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import Foundation

class NewsViewModel {
	
	var newsModel: [NewsModel] = []
	var selectedNewsModel: NewsModel?
	
	private let newsService: NewsService
	
	init(newsService: NewsService = NewsService()) {
		self.newsService = newsService
	}
	
	/// Fetch news
	func fetchNews(completion: @escaping () -> Void) {
		newsService.fetchNews { data, error in
			if let data {
				self.newsModel = data
				completion()
			}
			
			if let error {
				print("Error occur \(error.localizedDescription)")
				completion()
			}
		}
	}
	
}
