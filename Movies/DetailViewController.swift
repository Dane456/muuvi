//
//  DetailViewController.swift
//  Muuvi
//
//  Created by Dane Jordan on 5/1/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailView: DetailView! 
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movie.title
        
        Movie.getDetails(forMovie: movie) { [weak self] (details) in
            DispatchQueue.main.async {
                self?.detailView.setup(withDetails: details, movie: self!.movie)
                
            }
        }
        
        Movie.findMovies(withTitle: nil, forMovie: movie, page: 1) { [weak self] (movies) in
            DispatchQueue.main.async {
                if let movies = movies {
                    self?.detailView.setup(withSimilarMovies: movies)
                } 
            }
        }
    }

    class func getEntrySegueIdentifier() -> String {
       return "detailSegue"
    }

}
