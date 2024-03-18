//
//  MoviesEndpoint.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation
import API

enum MoviesEndpoint {
    case movie
    case movieDetail(id: Int)
}

extension MoviesEndpoint: Endpoint {
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .movie:
            return "/3/movie/top_rated"
        case let .movieDetail(id):
            return "/3/movie/\(id)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .movie, .movieDetail:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .movie, .movieDetail:
            return  [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .movie, .movieDetail:
            return ["api_key":"36208b8e44a20dcb221c274d4cc78c10"]
        }
    }
}

struct Constant {
    static var imageBaseUrl: String {"https://image.tmdb.org/t/p/w500/"}
}
