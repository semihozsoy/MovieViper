//
//  MoviesDetailPresenter.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation


protocol MovieDetailPresenterInterface: AnyObject {
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func movieDetails(_ detail: MoviesDetail)
    func movieDetailsFailed(_ message: String)
    var movieId: Int? { get set }
    var movieDetail: MovieDetailItems? { get set }
}

final class MovieDetailPresenter {
    
    weak var view: MovieDetailViewInterface?
    var router: MovieDetailRouterInterface?
    var interactor: MovieDetailInteractorInterface?
    var movieId: Int?
    var movieDetail: MovieDetailItems?
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func notifyViewLoaded() {
        interactor?.fetchMovieDetail(id: movieId ?? 0)
    }
    
    func notifyViewWillAppear() {
        view?.setScreenTitle(with: "Movie Details")
    }
    
    func movieDetails(_ detail: MoviesDetail) {
        self.movieDetail = detail
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.view?.setupViews()
        }
    }
    
    func movieDetailsFailed(_ message: String) {
        router?.presentPopUp(with: message)
    }
}
