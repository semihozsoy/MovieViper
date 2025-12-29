//
//  MoviesInteractorInterfaceSpy.swift
//  MovieViper
//
//  Created by Semih Özsoy on 29.12.2025.
//

import XCTest
@testable import MovieViper

final class MoviesInteractorInterfaceSpy: MoviesInteractorInterface {
    
    var fetchMoviesCalled = false
    var shouldReturnError = false
    var mockResponse: [MovieItems]?
    weak var presenter: MoviesPresenterInterface?
    
    func fetchMovies() {
        fetchMoviesCalled = true
        
        if shouldReturnError {
            presenter?.moviesFetchedFailed(with: "Test error message")
            return
        }
        
        if let stubResult = UnitTestStubs.result,
           let moviesResponse = stubResult.decode(MoviesResponse.self) {
            presenter?.moviesFetched(moviesResponse.results)
        } else if let mockResponse = mockResponse {
            presenter?.moviesFetched(mockResponse)
        }
    }
}
