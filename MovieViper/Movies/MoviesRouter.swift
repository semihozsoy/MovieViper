//
//  MoviesRouter.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import UIKit

protocol MoviesRouterInterface: AnyObject {
    func popBack()
    func performSegue(with identifier: String)
    func presentPopUp(with message: String)
    func routeToDetail(with detail: Int?)
    static func createModule(using navigationController: UINavigationController) -> MoviesViewController
}

final class MoviesRouter {
    
    var presenter: MoviesPresenterInterface?
    weak var navigationController: UINavigationController?
}

extension MoviesRouter: MoviesRouterInterface {
    static func createModule(using navigationController: UINavigationController) -> MoviesViewController {
        let view = UIStoryboard(
            name: "Movies",
            bundle: nil).instantiateViewController(
                identifier: "MoviesViewController") as! MoviesViewController
        let router = MoviesRouter()
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.navigationController = navigationController
        return view
    }
    
    func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func performSegue(with identifier: String) {
        self.navigationController?.visibleViewController?.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func presentPopUp(with message: String) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self?.navigationController?.visibleViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func routeToDetail(with id: Int?) {
        let detailVC = MovieDetailRouter.createModule()
        detailVC.presenter?.movieId = id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
