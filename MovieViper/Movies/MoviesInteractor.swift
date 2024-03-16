//
//  MoviesInteractor.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation
import API

protocol MoviesInteractorInterface: AnyObject {
    func fetchMovies()
}

final class MoviesInteractor {
    weak var presenter: MoviesPresenterInterface?
}

extension MoviesInteractor: MoviesInteractorInterface, HTTPClient {
    func fetchMovies() {
        sendRequest(endpoint: MoviesEndpoint.movie,
                    responseModel: MoviesResponse.self) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter?.moviesFetched(response.results)
            case let .failure(error):
                self?.presenter?.moviesFetchedFailed(with: error.localizedDescription)
            }
        }
       
    }
}

