//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 20/11/24.
//

import Foundation
import Combine
class ApiService {
	private let apiKey = "C3f030a72294caf3cfbc0675e82aa176"
	
	private lazy var urlSession: URLSession = {
		let config = URLSessionConfiguration.default
		config.timeoutIntervalForRequest = 30 // seconds
		config.timeoutIntervalForResource = 60 // seconds
		return URLSession(configuration: config)
	}()
	
	func fetchMovies(endpoint: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
		let urlString = "https://api.themoviedb.org/3/\(endpoint)?api_key=\(apiKey)"
		guard let url = URL(string: urlString) else { return }
		
		urlSession.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			guard let data = data else { return }
			
			do {
				let moviesResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
				completion(.success(moviesResponse.results))
			} catch {
				completion(.failure(error))
			}
		}.resume()
	}
}

class HomeViewModel: ObservableObject {
	@Published var trendingMovies: [Movie] = []
	@Published var popularMovies: [Movie] = []
	
	private var apiService = ApiService()
	
	func loadTrendingMovies() {
		apiService.fetchMovies(endpoint: "trending/movie/week") { result in
			switch result {
			case .success(let movies):
				DispatchQueue.main.async {
					self.trendingMovies = movies
				}
			case .failure(let error):
				print("Failed to load trending movies: \(error)")
			}
		}
	}
	
	func loadPopularMovies() {
		apiService.fetchMovies(endpoint: "movie/popular") { result in
			switch result {
			case .success(let movies):
				DispatchQueue.main.async {
					self.popularMovies = movies
				}
			case .failure(let error):
				print("Failed to load popular movies: \(error)")
			}
		}
	}
}
