//
//  SearchMovieView.swift
//  Movies
//
//  Created by Dane Jordan on 4/29/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

@IBDesignable
class SearchMovieView: UIView {
    
    var searchView: UIView!
    var delegate: SearchMovieDelegate?
    
//    @IBOutlet weak var movieInputField: UITextField! {
//        didSet {
//            // Create a bottom border
//            let border = CALayer()
//            border.borderColor = UIColor.white.cgColor
//            border.frame = CGRect(x: 0, y: movieInputField.bounds.size.height - 1.0,
//                                  width: movieInputField.bounds.size.width, height: movieInputField.bounds.size.height)
//            border.borderWidth = 1.0
//            movieInputField.layer.addSublayer(border)
//            movieInputField.layer.masksToBounds = true
//            
//            let placeholder = NSAttributedString(string: "Search for a movie here...",
//                                                 attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
//            movieInputField.attributedPlaceholder = placeholder
//        }
//    }
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.layer.borderWidth = 1.0
            searchButton.layer.borderColor = Colors.blue.cgColor
            searchButton.layer.cornerRadius = searchButton.bounds.size.height / 2
            searchButton.clipsToBounds = true
        }
    }
    @IBAction func continuePressed(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.nextScreen()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        searchView = loadViewFromNib()
        searchView.frame = bounds
        searchView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(searchView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first
        return nibView as! UIView
    }

}
