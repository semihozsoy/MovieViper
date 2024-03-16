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
    var viewModel: MovieItems? { get set }
}

final class MovieDetailPresenter {
    
    weak var view: MovieDetailViewInterface?
    var router: MovieDetailRouterInterface?
    var interactor: MovieDetailInteractorInterface?
    var viewModel: MovieItems?
    
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func notifyViewLoaded() {
        view?.setupViews()
    }
    
    func notifyViewWillAppear() {
        view?.setScreenTitle(with: "Movie Details")
    }
}
