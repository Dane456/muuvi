//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Dane Jordan on 4/30/17.
//  Copyright © 2017 Dane Jordan. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController, UISearchBarDelegate {
    
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
            movies.removeAll()
            searchForMovies()
        }
    }
    
    private func searchForMovies() {
        if let query = searchText, !query.isEmpty {
            self.title = query
            tableView.separatorStyle = .none
            Movie.findMovies(withTitle: query, page: 1) { (movies) in
                if movies.count == 0 {
                    let alert = UIAlertController(title: "Oops", message: "No results returned, try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                DispatchQueue.main.async {
                    self.movies = movies
                    self.tableView.backgroundView = nil
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if movies.count > 0 {
            tableView.separatorStyle = .singleLine
            return 1
        }
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

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
