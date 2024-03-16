//
//  MoviesDetailRouter.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import UIKit

protocol MovieDetailRouterInterface: AnyObject {
    static func createModule() -> MovieDetailViewController
}

final class MovieDetailRouter {
    
    var presenter: MovieDetailPresenterInterface?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
}

extension MovieDetailRouter: MovieDetailRouterInterface {
    static func createModule() -> MovieDetailViewController {
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        let view = UIStoryboard(
            name: "MovieDetail",
            bundle: nil).instantiateViewController(
                identifier: "movieDetailVC") as! MovieDetailViewController
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        return view
    }
}
