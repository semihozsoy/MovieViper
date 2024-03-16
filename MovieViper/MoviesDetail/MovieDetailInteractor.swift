//
//  MoviesDetailInteractor.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import Foundation


protocol MovieDetailInteractorInterface: AnyObject {}

final class MovieDetailInteractor {
    weak var presenter: MovieDetailPresenterInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {}
