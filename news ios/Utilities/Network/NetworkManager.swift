//
//  NetworkManager.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import Foundation

enum HTTPMethod: String {
	case GET, POST, PATCH, PUT, DELETE
}

enum NetworkError: Error {
	case invalidURL
	case requestFailed(message: String?)
	case invalidResponse
	case decodingError
}

class NetworkManager {
	static let shared = NetworkManager()
	private let jsonDecoder = JSONDecoder()
	private let baseUrl = "https://jsonplaceholder.org"
	
	private init() {}
	
	func request<T: Decodable>(
		url: String,
		method: HTTPMethod,
		parameters: Any? = nil,
		headers: [String: String]? = nil,
		responseType: T.Type,
		completion: @escaping (Result<T, NetworkError>) -> Void
	) {
		/// Validate and prepare the URL
		guard let requestURL = URL(string: baseUrl + url) else {
			completion(.failure(.invalidURL))
			return
		}
		
		/// Set up the request with method, headers, and parameters
		var request = URLRequest(url: requestURL)
		request.httpMethod = method.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		/// Add custom headers
		headers?.forEach { key, value in
			request.setValue(value, forHTTPHeaderField: key)
		}
		
		/// Encode parameters for non-GET requests
		if let parameters = parameters, method != .GET {
			do {
				request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
			} catch {
				print("err A = \(error)")
				completion(.failure(.decodingError))
				return
			}
		}
		
		/// Start the data task
		URLSession.shared.dataTask(with: request) { data, response, error in
			/// Handle request error
			if error != nil {
				DispatchQueue.main.async {
					completion(.failure(.requestFailed(message: error?.localizedDescription)))
				}
				return
			}
			
			/// Validate response status code
			if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
				if let data = data {
					do {
						let _ = try self.jsonDecoder.decode(BaseResponse<T>.self, from: data)
						
						DispatchQueue.main.async {
							completion(.failure(.requestFailed(message: "Error happen")))
						}
						
					} catch {
						DispatchQueue.main.async {
							completion(.failure(.invalidResponse))
						}
					}
				} else {
					DispatchQueue.main.async {
						completion(.failure(.invalidResponse))
					}
				}
				return
			}
			
			/// Decode the data
			guard let data = data else {
				DispatchQueue.main.async {
					completion(.failure(.invalidResponse))
				}
				return
			}
			
			do {
				let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
				DispatchQueue.main.async {
					completion(.success(decodedResponse))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(.decodingError))
				}
			}
		}.resume()
	}
}
