//
//  MoviesEntity.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation


protocol MovieDetailItems {
    var movieId: Int? { get }
    var movieName: String? { get }
    var movieImage: String? { get }
    var movieYear: String? { get }
    var movieDetail: String? { get }
}

extension MoviesDetail: MovieDetailItems {
    var movieId: Int? {
        id
    }
    
    var movieName: String? {
        originalTitle
    }
    
    var movieImage: String? {
        posterPath
    }
    
    var movieYear: String? {
        releaseDate
    }
    
    var movieDetail: String? {
        overview
    }
}
