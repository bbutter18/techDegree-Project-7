//
//  MovieListDataSource.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/19/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit




class MovieListDataSource: NSObject, UITableViewDataSource {

    private var data: [Movie]
    
    init(data: [Movie]) {
        self.data = data
        super.init()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    //***work on this****
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        let movie = object(at: indexPath)
        let viewModel = MovieCellViewModel(movie: movie)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("in selection...")
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("undoing selection...")
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    
    //Movie Cell Title Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Movie(s)"
    }
    
    // MARK: Helpers
    
    func update(_ object: Movie, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func updateData(_ data: [Movie]) {
        self.data = data
    }
    
    func object(at indexPath: IndexPath) -> Movie {
        return data[indexPath.row]
    }
}


