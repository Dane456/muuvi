//
//  DetailView.swift
//  Muuvi
//
//  Created by Dane Jordan on 5/1/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

@IBDesignable
class DetailView: UIView, UIScrollViewDelegate {
    
    var detailView: UIView!
    let SIMILARMOVIEHEIGHTWIDTHRATIO:CGFloat = 1.778
    
    @IBOutlet weak var similarMoviesScrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        detailView = loadViewFromNib()
        detailView.frame = bounds
        detailView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        detailView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(detailView)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first
        return nibView as! UIView
    }
    
    func setup(withDetails details: [String: Any], movie: Movie) {
        similarMoviesScrollView.delegate = self
        if let budget = details["budget"] as? Int {
            budgetLabel.text = "Budget: \(NumberFormatter.localizedString(from: NSNumber(integerLiteral: budget), number: .currencyAccounting))"
        } else {
            budgetLabel.text = "Budget N/A"
        }
        if let overview = details["overview"] as? String {
            descLabel.text = overview
        }
        if let companiesArray = details["production_companies"] as? Array<[String: Any]> {
            let companies = companiesArray.map({ (company) -> String in
                if let name = company["name"] as? String {
                    return name
                }
                return ""
            })
            companiesLabel.text = "Production Companies: \(companies.joined(separator: ", ")))"
        } else {
            companiesLabel.text = "Production Companies: N/A"
        }
        if let runtime = details["runtime"] as? Double {
            let hours = String(format: "%.0f", floor(runtime/60))
            let mins = String(format: "%.0f", runtime.truncatingRemainder(dividingBy: 60))
            runtimeLabel.text = "Runtime: \(hours)h \(mins)m"
        } else {
            runtimeLabel.text = "Runtime N/A"
        }
        if let revenue = details["revenue"] as? Int {
            revenueLabel.text = "Revenue: \(NumberFormatter.localizedString(from: NSNumber(integerLiteral: revenue), number: .currencyAccounting))"
        } else {
            revenueLabel.text = "Revenue: N/A"
        }
        var voteStr = " votes"
        if movie.numVotes == 1 {
            voteStr = " vote"
        }
        voteCountLabel.text = "\(movie.numVotes)\(voteStr)"
        voteAverageLabel.text = "\(movie.voteAverage.description) / 10"
        if movie.releaseDate != nil {
            dateCreatedLabel.text = movie.releaseDate
        }
        if let cachedImage = Store.imageCache.object(forKey: movie.posterPath as AnyObject) as? UIImage {
            posterImageView.image = cachedImage
        } else {
            let indicator = UIActivityIndicatorView(frame: posterImageView.frame)
            posterImageView.addSubview(indicator)
            indicator.startAnimating()
            Utils.loadImage(forView: posterImageView, path: movie.posterPath) {(posterImageView) in
                self.posterImageView = posterImageView
                indicator.stopAnimating()
            }
        }
    }
    
    func setup(withSimilarMovies movies: [Movie]) {

        let simMovieViewWidth = similarMoviesScrollView.frame.height / SIMILARMOVIEHEIGHTWIDTHRATIO
        
        for (i, movie) in movies.enumerated(){
            let simMovieView = SimilarMovieView()
            simMovieView.frame = CGRect(
                x: 0 + (CGFloat(i) * simMovieViewWidth),
                y: 0,
                width: simMovieViewWidth,
                height: similarMoviesScrollView.frame.height
            )
            simMovieView.setup(withMovie: movie)
            similarMoviesScrollView.addSubview(simMovieView)
        }
        
        similarMoviesScrollView.contentSize =  CGSize(width: CGFloat(movies.count) * simMovieViewWidth, height: similarMoviesScrollView.frame.height)
    }
}
