//
//  GenreListController.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/19/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

var genreArray: [Genre] = []

class GenreListController: UITableViewController {

    let movieClient = MovieDBClient()
    
    var populatedAPIGenreArray: [Genre] = []

    lazy var dataSource: GenreListDataSource = {
        return GenreListDataSource(data: [])
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        self.tableView.allowsMultipleSelection = true
       
        movieClient.getGenres() { [weak self] results in
            switch results {
            case .success(let genre):
                self?.dataSource.updateData(genre)
                self?.tableView.reloadData()
                for i in genre {
                    self?.populatedAPIGenreArray.append(i)
                }
            case .failure(let error):
                print(error)
                self?.displayAlert(title: "Error", message: "No Internet Connection")
            }
        }
    }
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selecting a genre...")
        tableView.deselectRow(at: indexPath, animated: true)
        
        var type = populatedAPIGenreArray[indexPath.row]
        type.selected = !populatedAPIGenreArray[indexPath.row].selected
        populatedAPIGenreArray[indexPath.row] = type
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                for (index, typeSelected) in genreArray.enumerated() {
                    if typeSelected.id == type.id {
                        genreArray.remove(at: index)
                    }
                }
            } else {
                cell.accessoryType = .checkmark
                genreArray.append(type)
            }
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func userMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "SecondUserSegue", sender: nil)
        print("Performing Main Menu Segue")
        print(genreArray.count)
    }
    
}
