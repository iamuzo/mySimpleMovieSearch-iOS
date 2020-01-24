//
//  MoviesAPIService.swift
//  mySimpleMovieDB
//
//  Created by Uzo on 1/24/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MoviesAPIService {
    
    static func fetchMovie(searchTerm: String, completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: retrieveAPIKey()),
            URLQueryItem(name: "query", value: "\(searchTerm)")
        ]
        
        guard let searchURL = components.url else {
            return completion(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let decoder = JSONDecoder()
                let topLevelDict = try decoder.decode(TopLevelDict.self, from: data)
                completion(.success(topLevelDict.results))
            } catch {
                print(error)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func getImageFor(movie: Movie, completion: @escaping(Result<UIImage?, MovieError>) -> Void ){
        
        guard let baseURL = URL(string: "https://image.tmdb.org")?.appendingPathComponent("t").appendingPathComponent("p").appendingPathComponent("w200").appendingPathComponent(movie.posterPath) else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print(error)
                return completion(.failure(.invalidURL))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.noImage))
            }
            
            
        }.resume()
    }
    
    static func retrieveAPIKey() -> String {
        guard let filepath = Bundle.main.path(forResource: "AuthKeys", ofType: "plist") else {
            print("AuthKeys.plist not found");
            return "error"
        }
        
        let propertyList = NSDictionary.init(contentsOfFile: filepath)
        guard let apiKey = propertyList?.value(forKey: "moviedb") as? String else {
            print("Improper drilling into PropertyList file.")
            return "" }
        return apiKey
    }
}


enum MovieError: LocalizedError {
    case invalidURL
    case noData
    case unableToDecodeData
    case thrownError(Error)
    case noImage
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
            return "Unable to reach the server"
            case .noData:
            return "The server responded with no data"
            case .unableToDecodeData:
            return "The server responded with bad data"
            case .thrownError(let error):
                return "\(error.localizedDescription)"
            case .noImage:
            return "failed to decode image"
        }
    }
}
