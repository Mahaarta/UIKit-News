//
//  BaseResponse.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
	let error: Bool
	let statusCode: Int
	let actionCode: Int
	let data: T?
}
