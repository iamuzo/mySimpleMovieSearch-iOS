//
//  MovieDetailViewController.swift
//  mySimpleMovieDB
//
//  Created by Uzo on 1/24/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    var movie: Movie?
    
    // MARK: - Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Custom Methods
    func updateViews() {
        guard let selectedMovie = movie else { return }
        
        MoviesAPIService.getImageFor(movie: selectedMovie) { (result) in
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
            let title = selectedMovie.title
            let rating = selectedMovie.rating
            let overview = selectedMovie.overview
            self.movieTitleLabel.text = "Movie Title: \(title)"
            self.movieRatingLabel.text = "Movie Rating: \(rating)"
            self.movieOverViewLabel.text = overview
        }
    }

}
