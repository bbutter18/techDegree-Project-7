//
//  PeopleListController.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/19/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

var peopleArray: [People] = []

class PeopleListController: UITableViewController {
    
    let movieClient = MovieDBClient()
    
    var populatedAPIPersonArray: [People] = []

    lazy var dataSource: PeopleListDataSource = {
        return PeopleListDataSource(data: [])
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        self.tableView.allowsMultipleSelection = true
        
        movieClient.getPeople() { [weak self] results in
            switch results {
            case .success(let people):
                self?.dataSource.updateData(people)
                self?.tableView.reloadData()
                for i in people {
                    self?.populatedAPIPersonArray.append(i)
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
        print("selecting an actor...")
        tableView.deselectRow(at: indexPath, animated: true)
        
        var type = populatedAPIPersonArray[indexPath.row]
        type.selected = !populatedAPIPersonArray[indexPath.row].selected
        populatedAPIPersonArray[indexPath.row] = type
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                for (index, typeSelected) in peopleArray.enumerated() {
                    if typeSelected.id == type.id {
                        peopleArray.remove(at: index)
                    }
                }
            } else {
                cell.accessoryType = .checkmark
                peopleArray.append(type)
                
            }
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    

    @IBAction func genreSelectionButton(_ sender: Any) {
        performSegue(withIdentifier: "ShowGenres", sender: nil)
        print("Performing Genre Segue")
        print(peopleArray.count)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
