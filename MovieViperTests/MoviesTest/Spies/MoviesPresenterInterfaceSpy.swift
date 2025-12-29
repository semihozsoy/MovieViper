//
//  MoviesPresenterInterfaceSpy.swift
//  MovieViper
//
//  Created by Semih Özsoy on 29.12.2025.
//
import XCTest
@testable import MovieViper

final class MoviesPresenterInterfaceSpy: MoviesPresenterInterface {
    
    var getMovieViewModelsCalled = false
    var notifyViewLoadedCalled = false
    var notifyViewWillAppearCalled = false
    var moviesFetchedCalled = false
    var moviesFetchedFailedCalled = false
    var movieDetailCalled = false
    
    var mockMovies: [MovieItems]?
    var capturedResponse: [MovieItems]?
    var capturedErrorMessage: String?
    var capturedMovieIndex: Int?
    
    func getMovieViewModels() -> [MovieViper.MovieItems]? {
        getMovieViewModelsCalled = true
        return mockMovies ?? []
    }
    
    func notifyViewLoaded() {
        notifyViewLoadedCalled = true
    }
    
    func notifyViewWillAppear() {
        notifyViewWillAppearCalled = true
    }
    
    func moviesFetched(_ response: [MovieViper.MovieItems]?) {
        moviesFetchedCalled = true
        capturedResponse = response
    }
    
    func moviesFetchedFailed(with errorMessage: String) {
        moviesFetchedFailedCalled = true
        capturedErrorMessage = errorMessage
    }
    
    func movieDetail(_ index: Int) {
        movieDetailCalled = true
        capturedMovieIndex = index
    }
}
