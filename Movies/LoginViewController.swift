//
//  ViewController.swift
//  Movies
//
//  Created by Dane Jordan on 4/29/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit
protocol LoginDelegate: class {
    func nextScreen()
}

class LoginViewController: UIViewController, LoginDelegate {
    
    @IBOutlet weak var loginView: LoginView! {
        didSet {
            loginView.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func nextScreen() {
         self.performSegue(withIdentifier: MoviesTableViewController.getEntrySegueIdentifier(), sender: nil)
    }
}

