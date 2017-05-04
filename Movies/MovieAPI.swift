//
//  MovieAPI.swift
//  Muuvi
//
//  Created by Dane Jordan on 5/1/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import Foundation

extension Movie {
    
    static func findMovies(withTitle title: String?, forMovie movie: Movie?, page: Int?, completion:  @escaping ([Movie]?) -> Void) {
        if let apiKey = ProcessInfo.processInfo.environment["apiKey"] {
            var searchUrlComponents = Movie.urlComponents
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
            if let title = title {
                searchUrlComponents.path = "/3/search/movie"
                let pageNum = page ?? 1
                queryItems.append(contentsOf: [ URLQueryItem(name: "query", value: title),
                                                URLQueryItem(name: "language", value: "en-US"),
                                                URLQueryItem(name: "include_adult", value: "true"),
                                                URLQueryItem(name: "page", value: "\(pageNum)")])
                
            } else if let movie = movie {
                searchUrlComponents.path = "/3/movie/\(movie.id)/similar"
                
            }
            searchUrlComponents.queryItems = queryItems
            let url = searchUrlComponents.url!
            Movie.session.dataTask(with: url, completionHandler: { (data, response, error) in
                var movies:[Movie] = []
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let results = json?["results"] as! [[String: Any]]
                        for result in results {
                            if let movie = Movie(json: result) {
                                movies.append(movie)
                            }
                        }
                    } catch let error {
                        print("Serialization error: \(error) ")
                    }
                } else if let error = error {
                    print("Request Error: \(error.localizedDescription)")
                }
                completion(movies)
            }).resume()
        } else {
            completion(nil)
            print("no api key present")
        }
    }
    
    static func getDetails(forMovie movie: Movie, completion: @escaping ([String: Any]) -> Void) {
        if let apiKey = ProcessInfo.processInfo.environment["apiKey"] {
            var detailSearchComponents = Movie.urlComponents
            detailSearchComponents.path = "/3/movie/\(movie.id)"
            detailSearchComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
            let url = detailSearchComponents.url!
            Movie.session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completion(json!)
                    } catch let error {
                        print("Serialization error: \(error)")
                    }
                } else if let error = error {
                    print("Request Error: \(error)")
                }
            }).resume()
        } else {
            print("No api key present")
        }
    }
}
