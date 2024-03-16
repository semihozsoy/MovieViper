//
//  MoviesDetailViewController.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import UIKit
import SDWebImage

protocol MovieDetailViewInterface: AnyObject {
    func setupViews()
    func setScreenTitle(with title: String)
}

final class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieType: UILabel!
    
    var presenter: MovieDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
}

extension MovieDetailViewController: MovieDetailViewInterface {
    
    func setupViews() {
        movieImage.sd_setImage(with: URL(string: "\(Constant.imageBaseUrl)\(presenter?.movieDetail?.movieImage ?? "")"))
        movieName.text = "Movie Name: \(presenter?.movieDetail?.movieName ?? "")"
        movieYear.text = "Movie Year: \(presenter?.movieDetail?.movieYear ?? "")"
        movieType.text = "Overview:\n \(presenter?.movieDetail?.movieDetail ?? "")"
    }
    
    func setScreenTitle(with title: String) {
        self.title = title
    }
}
