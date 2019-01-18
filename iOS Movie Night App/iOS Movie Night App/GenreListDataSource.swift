//
//  GenreListDataSource.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/19/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit


class GenreListDataSource: NSObject, UITableViewDataSource {


    private var data: [Genre]
    
    init(data: [Genre]) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreCell.reuseIdentifier, for: indexPath) as! GenreCell
        
        let genre = object(at: indexPath)
        let viewModel = GenreCellViewModel(genre: genre)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    
    //Genre Cell Title Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Genre(s)"
    }
    
    // MARK: Helpers
    
    func update(_ object: Genre, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func updateData(_ data: [Genre]) {
        self.data = data
    }
    
    func object(at indexPath: IndexPath) -> Genre {
        return data[indexPath.row]
    }
}

