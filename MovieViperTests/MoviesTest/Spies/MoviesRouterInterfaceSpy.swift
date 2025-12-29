//
//  MoviesRouterInterfaceSpy.swift
//  MovieViper
//
//  Created by Semih Özsoy on 29.12.2025.
//
import XCTest
@testable import MovieViper

final class MoviesRouterInterfaceSpy: MoviesRouterInterface {
    
    var popBackCalled = false
    var performSegueCalled = false
    var presentPopUpCalled = false
    var routeToDetailCalled = false
    
    var capturedSegueIdentifier: String?
    var capturedPopUpMessage: String?
    var capturedMovieId: Int?
    
    func popBack() {
        popBackCalled = true
    }
    
    func performSegue(with identifier: String) {
        performSegueCalled = true
        capturedSegueIdentifier = identifier
    }
    
    func presentPopUp(with message: String) {
        presentPopUpCalled = true
        capturedPopUpMessage = message
    }
    
    func routeToDetail(with detail: Int?) {
        routeToDetailCalled = true
        capturedMovieId = detail
    }
    
    static func createModule(
        using navigationController: UINavigationController
    ) -> MovieViper.MoviesViewController {
        return MoviesViewController()
    }
}
