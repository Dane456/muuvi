//
//  DetailViewController.swift
//  Muuvi
//
//  Created by Dane Jordan on 5/1/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func getEntrySegueIdentifier() -> String {
       return "detailSegue"
    }

}
