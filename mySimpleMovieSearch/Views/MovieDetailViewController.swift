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
        let title = selectedMovie.title
        let rating = selectedMovie.rating
        let image = selectedMovie.posterPath
        movieTitleLabel.text = "Movie Title: \(title)"
        movieRatingLabel.text = "Movie Rating: \(rating)"
        movieOverViewLabel.text = selectedMovie.overview
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
