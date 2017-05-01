//
//  ViewController.swift
//  Movies
//
//  Created by Dane Jordan on 4/29/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit
protocol SearchMovieDelegate: class {
    func nextScreen()
}

class LoginViewController: UIViewController, SearchMovieDelegate {
    
    @IBOutlet weak var searchView: SearchMovieView! {
        didSet {
            searchView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func nextScreen() {
         self.performSegue(withIdentifier: MoviesTableViewController.getEntrySegueIdentifier(), sender: nil)
    }
//    
//    func displayError() {
//        let alert = UIAlertController(title: "Oops", message: "Please input a movie to search!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
}

