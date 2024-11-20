struct MovieResponse: Codable {
	let results: [Movie]
}

struct Movie: Identifiable, Codable {
	let id: Int
	let title: String
	let overview: String
	let releaseDate: String
	let voteAverage: Double
	let posterPath: String?
	
	var fullPosterPath: String {
		"https://image.tmdb.org/t/p/w500" + (posterPath ?? "")
	}
	
	private enum CodingKeys: String, CodingKey {
		case id
		case title
		case overview
		case releaseDate = "release_date"
		case voteAverage = "vote_average"
		case posterPath = "poster_path"
	}
}
