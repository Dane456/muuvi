//
//  SimilarMovieView.swift
//  Muuvi
//
//  Created by Dane Jordan on 5/2/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

@IBDesignable
class SimilarMovieView: UIView {
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var similarMovieView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        similarMovieView = loadViewFromNib()
        similarMovieView.frame = bounds
        similarMovieView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        similarMovieView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(similarMovieView)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first
        return nibView as! UIView
    }
    
    func setup(withMovie movie: Movie) {
        titleLabel.text = movie.title
        if let cachedImage = Store.imageCache.object(forKey: movie.posterPath as AnyObject) as? UIImage {
            self.posterView.image = cachedImage
        } else {
            let indicator = UIActivityIndicatorView(frame: posterView.frame)
            posterView.addSubview(indicator)
            indicator.startAnimating()
            Utils.loadImage(forView: posterView, path: movie.posterPath) {(posterImageView) in
                self.posterView = posterImageView
                indicator.stopAnimating()
            }
        }
    }
}
