//
//  Movie.swift
//  mySimpleMovieDB
//
//  Created by Uzo on 1/24/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

struct TopLevelDict: Codable {
    var results: [Movie]
}

struct Movie: Codable {
    var title: String
    var rating: Double
    var overview: String
    var posterPath: String
}


extension Movie {
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case rating = "vote_average"
        case posterPath = "poster_path"
    }
}
