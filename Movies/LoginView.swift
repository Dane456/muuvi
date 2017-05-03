//
//  SearchMovieView.swift
//  Movies
//
//  Created by Dane Jordan on 4/29/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

@IBDesignable
class LoginView: UIView {
    
    var loginView: UIView!
    var delegate: LoginDelegate?

    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.layer.borderWidth = 1.0
            searchButton.layer.borderColor = UIColor.cyan.cgColor
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
        loginView = loadViewFromNib()
        loginView.frame = bounds
        loginView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loginView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(loginView)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first
        return nibView as! UIView
    }
}
