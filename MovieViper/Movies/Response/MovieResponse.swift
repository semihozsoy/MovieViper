//
//  MovieResponse.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int?
    let results: [Movies]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movies: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


//// MARK: - MoviesResponse
//struct MoviesResponse: Codable {
//    let search: [Search]?
//    let totalResults, response: String?
//
//    enum CodingKeys: String, CodingKey {
//        case search = "Search"
//        case totalResults
//        case response = "Response"
//    }
//}
//
//// MARK: - Search
//struct Search: Codable {
//    let title, year, imdbID, type: String?
//    let poster: String?
//
//    enum CodingKeys: String, CodingKey {
//        case title = "Title"
//        case year = "Year"
//        case imdbID
//        case type = "Type"
//        case poster = "Poster"
//    }
//}
