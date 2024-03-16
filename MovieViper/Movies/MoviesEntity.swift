//
//  MoviesEntity.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation


protocol MovieItems {
    var movieName: String? { get }
    var movieImage: String? { get }
    var movieYear: String? { get }
    var movieType: String? { get }
}

extension Search: MovieItems {
    var movieName: String? {
        title
    }
    
    var movieImage: String? {
        poster
    }
    
    var movieYear: String? {
        year
    }
    
    var movieType: String? {
        type
    }
}
