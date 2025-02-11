//
//  NewsModel.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import Foundation

struct NewsModel: Codable {
	let id: Int?
	let slug: String?
	let url: String?
	let title: String?
	let content: String?
	let image: String?
	let thumbnail: String?
	let status: String?
	let category: String?
	let publishedAt: String?
	let updatedAt: String?
}
