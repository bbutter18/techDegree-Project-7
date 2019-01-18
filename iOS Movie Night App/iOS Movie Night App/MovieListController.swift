//
//  MovieListController.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/19/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

class MovieListController: UITableViewController {
    
    let movieClient = MovieDBClient()
    
    lazy var dataSource: MovieListDataSource = {
        return MovieListDataSource(data: [])
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        self.tableView.allowsMultipleSelection = true
        movieClient.getMovies(people: peopleArray, genres: genreArray) { [weak self] results in
            switch results {
            case .success(let movie):
                self?.dataSource.updateData(movie)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
                self?.displayAlert(title: "Error", message: "No Matches Found \nPlease Try Again")
            }
        }
        
    }
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backToMainMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToMainMenuSegue", sender: nil)
        print("Performing Main Menu Segue")
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
