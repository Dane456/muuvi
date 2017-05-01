//
//  Movie.swift
//  Movies
//
//  Created by Dane Jordan on 4/29/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import Foundation

struct Movie {
    
    private static let urlComponents = URLComponents(string: "https://api.themoviedb.org")!
    private static let imageUrlComponents = URLComponents(string: "https://image.tmdb.org")!
    private static let session = URLSession(configuration: .default)
    
    let id: Int
    let title:String
    let desc:String
    let posterPath:URL
    let voteAverage:Double
    let numVotes: Int
    let releaseDate: String?
    
    init?(json: [String: Any]) {
        guard let apiKey = ProcessInfo.processInfo.environment["apiKey"],
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let desc = json["overview"] as? String,
            let posterPath = json["poster_path"] as? String,
            let voteAverage = json["vote_average"] as? Double,
            let numVotes = json["vote_count"] as? Int,
            let releaseDate = json["release_date"] as? String
        else {
            return nil
        }
        self.title = title
        self.id = id
        self.desc = desc
        var url = Movie.imageUrlComponents
        url.path = "/t/p/w300\(posterPath)"
        self.posterPath = url.url!
        self.voteAverage = voteAverage
        self.numVotes = numVotes
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: releaseDate) {
            dateFormatter.dateStyle = .long
            self.releaseDate = dateFormatter.string(from: date)
        } else {
            self.releaseDate = nil
        }
    }
    
    static func findMovies(withTitle title: String, page: Int?, completion:  @escaping ([Movie]) -> Void) {
        if let apiKey = ProcessInfo.processInfo.environment["apiKey"] {
            var searchUrlComponents = Movie.urlComponents
            searchUrlComponents.path = "/3/search/movie"
            let pageNum = page ?? 1
            searchUrlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                              URLQueryItem(name: "query", value: title),
                                              URLQueryItem(name: "language", value: "en-US"),
                                              URLQueryItem(name: "include_adult", value: "true"),
                                              URLQueryItem(name: "page", value: "\(pageNum)")]
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
            print("no api key present")
        }
    }
}
