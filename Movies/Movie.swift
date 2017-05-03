//
//  Movie.swift
//  Movies
//
//  Created by Dane Jordan on 4/29/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import Foundation

struct Movie {
    
    static let urlComponents = URLComponents(string: "https://api.themoviedb.org")!
    static let imageUrlComponents = URLComponents(string: "https://image.tmdb.org")!
    static let session = URLSession(configuration: .default)
    static var pages = 1
    
    let id: Int
    let title:String
    let desc:String
    let posterPath:URL
    let voteAverage:Double
    let numVotes: Int
    let releaseDate: String?
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
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
}
