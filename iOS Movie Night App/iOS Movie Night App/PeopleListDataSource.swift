//
//  PeopleListDataSource.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/19/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit



class PeopleListDataSource: NSObject, UITableViewDataSource {

    private var data: [People]
        
    init(data: [People]) {
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
    
    //first we dequeue a cell with an identifier. It's exactly the same identifier we used before, when registering the cell. That way the table view knows what type of cell we want. The dequeued cell is assigned to the cell constant. Now we have a table view cell to work with. Then we assign the name of the Person to the text label of this table view cell. the contacts[indexPath.row][0] contains the value of the name of the contact, which we get to by using indexPath.row. Every instance of UITableViewCell has a property textLabel of UILabel, and every label of that type has a property text. You use it to set the text on the label
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseIdentifier, for: indexPath) as! PersonCell //at this point we have a problem because cell is an optional now, it's type is UITableViewCell but the function return type demands that we return an instance with non-optional type UITableViewCell. Fortunately htis is one of those instances where we can safely use force unwrapping to unwrap the optional value.
        
        let person = object(at: indexPath)
        let viewModel = PersonCellViewModel(person: person)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    //Every time the table view controllers needs a cell from tableView it provides an index path as an argument for the function. Within the function body you can use the parameter indexPath to know exactly which cell the table view controller needs. An index path is like an address, a coordinate in that graph as x, y like 0, 1 and 43, 3.  Similarly, a spreadsheet has rows and columns with indices. 
    //A table view uses sections and rows. The secions and rows of a table view are what columns and rows are to a spreadsheet. An index path defines a location in the table view, by using a row and a section. The rows an sections are represented by numbers called indices. These indices start at zero, so the first row and section will have index number 0.The first cell has index path 0,0. The second cell 0,1 continuing up to the last visible cell with index path 0,11.
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("in selection...")
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//            if cell.accessoryType == .checkmark {
//                cell.accessoryType = .none
//            } else {
//                cell.accessoryType = .checkmark
//            }
//        }
//    }
    
    
    //People Cell Title Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select People(s)"
    }
    
    // MARK: Helpers
    
    func update(_ object: People, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func updateData(_ data: [People]) {
        self.data = data
    }
    
    func object(at indexPath: IndexPath) -> People {
        return data[indexPath.row]
    }
}


