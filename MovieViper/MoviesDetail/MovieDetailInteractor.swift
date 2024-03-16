//
//  MoviesDetailInteractor.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation
import API


protocol MovieDetailInteractorInterface: AnyObject {
    func fetchMovieDetail(id: Int)
}

final class MovieDetailInteractor {
    weak var presenter: MovieDetailPresenterInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface, HTTPClient {
    
    func fetchMovieDetail(id: Int) {
        sendRequest(
            endpoint: MoviesEndpoint.movieDetail(id: id),
            responseModel: MoviesDetail.self) { [weak self] result in
                switch result {
                case let .success(response):
                    self?.presenter?.movieDetails(response)
                case let .failure(error):
                    self?.presenter?.movieDetailsFailed(error.localizedDescription)
                }
        }
    }
}
