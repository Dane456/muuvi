//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Dane Jordan on 4/30/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController, UISearchBarDelegate {
    
    let LAZYLOADBUFFER = 5
    
    @IBOutlet weak var searchTextField: UISearchBar! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = searchBar.text
    }
    
    var movies = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? {
        didSet {
            Movie.pages = 1
            movies.removeAll()
            searchForMovies()
        }
    }
    
    private func searchForMovies() {
        if let query = searchText, !query.isEmpty {
            self.title = "Search results for \(query)"
            tableView.separatorStyle = .none
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            Movie.findMovies(withTitle: query, forMovie: nil, page: 1) { (movies) in
                if movies.count == 0 {
                    let alert = UIAlertController(title: "Oops", message: "No results returned, try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.movies = movies
                    self.tableView.backgroundView = nil
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.becomeFirstResponder()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if movies.count > 0 {
            tableView.separatorStyle = .singleLine
            return 1
        }
        let label = UILabel(frame: view.frame)
        label.text = "Enter search query above"
        label.textColor = .darkGray
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
    
    func fetchMoreMovies() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Movie.pages += 1
        Movie.findMovies(withTitle: searchText!, forMovie: nil, page: Movie.pages) {[weak self] (movies) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.movies.append(contentsOf: movies)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: DetailViewController.getEntrySegueIdentifier(), sender: movies[indexPath.row])
    }
    
    class func getEntrySegueIdentifier() -> String {
        return "login"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.getEntrySegueIdentifier() {
            if let destVC = segue.destination.contentViewController as? DetailViewController {
                destVC.movie = sender as! Movie
            }
        }
    }
}
