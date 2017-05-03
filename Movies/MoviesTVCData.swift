//
//  MoviesTVCData.swift
//  Muuvi
//
//  Created by Dane Jordan on 5/3/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import Foundation
import UIKit

extension MoviesTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if movies.count > 0 {
            tableView.separatorStyle = .singleLine
            return 1
        }
        let label = UILabel(frame: view.frame)
        label.text = "Enter search query above"
        label.textColor = .darkGray
        label.font = UIFont(name: "Avenir", size: 18)
        label.textAlignment = .center
        tableView.backgroundView = label
        tableView.separatorStyle = .none
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableCell", for: indexPath) as! MovieTableViewCell
        
        // Configure the cell...
        cell.setup(withMovie: movies[indexPath.row])
        
        if (indexPath.row + LAZYLOADBUFFER >= movies.count) {
            fetchMoreMovies()
        }
        
        return cell
    }
}
