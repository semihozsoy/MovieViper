//
//  MovieTableViewCell.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 14.03.2024.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(movie: MovieItems?) {
        movieImage.sd_setImage(with: URL(string: movie?.movieImage ?? ""))
        movieNameLabel.text = movie?.movieName ?? ""
    }
    
}
