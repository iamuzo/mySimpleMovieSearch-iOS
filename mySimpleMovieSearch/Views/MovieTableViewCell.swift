//
//  MovieTableViewCell.swift
//  mySimpleMovieDB
//
//  Created by Uzo on 1/24/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    func updateCell(withMovie movie: Movie?) {
        guard let existingMovie = movie else { return }
        
        MoviesAPIService.getImageFor(movie: existingMovie) { (result) in
            
            switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.moviePosterImageView.image = image
                }
                
                case .failure(let error):
                print(error)
            }
        }
        
        DispatchQueue.main.async {
            let title = existingMovie.title
            let rating = existingMovie.rating
            let overview = existingMovie.overview
            self.movieTitleLabel.text = "Title: \(title)"
            self.movieRatingLabel.text = "Rating: \(rating)"
            self.movieOverViewLabel.text = overview
        }
        print(existingMovie)

    }

}
