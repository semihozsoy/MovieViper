//
//  MoviesViewController.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import UIKit

protocol MoviesViewInterface: AnyObject {
    func prepareIndicator()
    func stopAnimating()
    func startAnimating()
    func reloadData()
    func setupInitialView()
    func setScreenTitle(with title: String)
}

final class MoviesViewController: UIViewController {
    
    var presenter: MoviesPresenterInterface?
    @IBOutlet var tableView: UITableView!
    private let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
    
}

extension MoviesViewController: MoviesViewInterface {
    
    func prepareIndicator() {
        view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.style = .large
        indicator.center = self.view.center
    }
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setupInitialView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "MovieTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "movieCell")
    }
    
    func setScreenTitle(with title: String) {
        self.title = title
    }
}

extension MoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieViewModels = presenter?.getMovieViewModels() else {
            return 0
        }
        return movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(movie: presenter?.getMovieViewModels()?[indexPath.row])
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.movieDetail(indexPath.row)
    }
}
