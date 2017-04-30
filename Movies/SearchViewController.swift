//
//  ViewController.swift
//  Movies
//
//  Created by Dane Jordan on 4/29/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit
protocol SearchMovieDelegate: class {
    func searchForMovie(withTitle: String)
    func displayError()
}

class SearchViewController: UIViewController, SearchMovieDelegate {
    
    @IBOutlet weak var searchView: SearchMovieView! {
        didSet {
            searchView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchForMovie(withTitle title: String) {
        
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Oops", message: "Please input a movie to search!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

