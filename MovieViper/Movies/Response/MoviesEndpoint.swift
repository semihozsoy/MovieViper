//
//  MoviesEndpoint.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation
import API

enum MoviesEndpoint {
    case movie(key: String)
}

extension MoviesEndpoint: Endpoint {
    
    var scheme: String {
        "http"
    }
    
    var host: String {
        "www.omdbapi.com"
    }
    
    var path: String {
        switch self {
        case .movie:
            return ""
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .movie:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .movie:
            return ["Content-Type": "application/json;charset=utf-8"]
        }
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryItems: [String: String]? {
        switch self {
        case let .movie(key):
            return ["s": key,"page": "1", "apikey": "2cc4d909"]
        }
    }
    
    
    // URLQueryItem(name: "s", value: "guard"),URLQueryItem(name: "apikey", value: "2cc4d909")
    // http://www.omdbapi.com/?s=guard&type=movie&page=1&apikey=2cc4d909
}
