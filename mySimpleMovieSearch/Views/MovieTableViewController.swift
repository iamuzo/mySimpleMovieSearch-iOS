//
//  MovieTableViewController.swift
//  mySimpleMovieDB
//
//  Created by Uzo on 1/24/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit


class MovieTableViewController: UITableViewController {

    // MARK:- PROPERTIES
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - OUTLETS
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    // MARK:- ACTIONS

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.updateCell(withMovie: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayMovieDetailVC" {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? MovieDetailViewController else {
                    return
            }
            
            let movie = movies[selectedIndexPath.row]
            
            destinationVC.movie = movie
        }
    }
}


extension MovieTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        print(searchTerm)
        
         //then call on MoviesAPIService.fetchmovie(searchTerm: searchTerm)
        MoviesAPIService.fetchMovie(searchTerm: searchTerm) { (result) in
            switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                print(error)
            }
        }
    }
}
