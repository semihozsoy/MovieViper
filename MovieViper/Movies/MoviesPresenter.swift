//
//  MoviesPresenter.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation

protocol MoviesPresenterInterface: AnyObject {
    func getMovieViewModels() -> [MovieItems]?
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func moviesFetched(_ response: [MovieItems]?)
    func moviesFetchedFailed(with errorMessage: String)
    func movieDetail(_ index: Int)
}

final class MoviesPresenter {
    
    weak var view: MoviesViewInterface?
    var router: MoviesRouterInterface?
    var interactor: MoviesInteractorInterface?
    var movieViewModels:[MovieItems]?
}

extension MoviesPresenter: MoviesPresenterInterface {
    
    func getMovieViewModels() -> [MovieItems]? {
        return movieViewModels
    }
    
    func notifyViewLoaded() {
        view?.setupInitialView()
        view?.prepareIndicator()
        interactor?.fetchMovies()
    }
    
    func notifyViewWillAppear() {
        view?.setScreenTitle(with: "Movies")
    }

    func moviesFetched(_ response: [MovieItems]?) {
        self.movieViewModels = response
        DispatchQueue.main.async { [weak self] in
            self?.view?.startAnimating()
            self?.view?.reloadData()
            self?.view?.stopAnimating()
        }
    }
    
    func moviesFetchedFailed(with errorMessage: String) {
        router?.presentPopUp(with: errorMessage)
    }
    
    func movieDetail(_ index: Int) {
        router?.routeToDetail(with: movieViewModels?[index].movieId)
    }
}

