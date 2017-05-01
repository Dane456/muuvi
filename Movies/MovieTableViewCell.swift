//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Dane Jordan on 4/30/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var numVotes: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    @IBOutlet weak var overview: UILabel!

    func setup(withMovie movie: Movie) {
        title.text = movie.title
        rating.text = movie.voteAverage.description + "/10"
        var voteStr = " votes"
        if movie.numVotes == 1 {
            voteStr = " vote"
        }
        numVotes.text = voteStr
        dateCreated.text = movie.releaseDate?.description
        overview.text = movie.desc
        let indicator = UIActivityIndicatorView(frame: posterView.frame)
        posterView.addSubview(indicator)
        indicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let posterImage = try? UIImage(data: Data(contentsOf: movie.posterPath)) {
                DispatchQueue.main.async {
                    self.posterView.image = posterImage
                    indicator.stopAnimating()
                }
            } else {
                print("Poster with url \(movie.posterPath) could not be fetched")
                
            }
        }
    }
    
}
