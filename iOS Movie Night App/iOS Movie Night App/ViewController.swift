//
//  ViewController.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/15/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//
import Foundation
import UIKit

var userOne = UserOne()
var userTwo = UserTwo()

class ViewController: UIViewController {
    
    var user1ButtonSelected: Bool = false
    var user2ButtonSelected: Bool = false
    
    @IBOutlet weak var user1: UIButton!
    @IBOutlet weak var user2: UIButton!
    
    @IBOutlet weak var viewResults: UIButton!
    @IBOutlet weak var clearResults: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewResults.isHidden = true
        clearResults.isHidden = true
        
        clearUserResults()
        getMoviesFromSelections()
        print(userOne.isSelected)
        print(userTwo.isSelected)
        movieIconChecked()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clearUserResults() {
        if userOne.isSelected == true || userTwo.isSelected == true {
            clearResults.isHidden = false
        }
    }
    
    func getMoviesFromSelections() {
        if userOne.isSelected == true && userTwo.isSelected == true {
            viewResults.isHidden = false
        }
    }
    
    func movieIconChecked() {
        if userOne.isSelected == true {
            user1.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
            user1.isEnabled = false
        }
        
        if userTwo.isSelected == true {
            user2.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
            user2.isEnabled = false
        }
    }
    
    
    @IBAction func clearResultsButton(_ sender: Any) {
        peopleArray = []
        genreArray = []
        viewResults.isHidden = true
        userOne.isSelected = false
        userTwo.isSelected = false
        user1.isEnabled = true
        user2.isEnabled = true
        user1.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
        user2.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
    }
    
    
    @IBAction func viewResultsButton(_ sender: Any) {
        //corners rounded code
        //if both icons have been used, performSegue(withIdentifier: "MovieListResults", sender: nil)
        print("Performing Movie List Segue")
    }
    
    
    @IBAction func userOneSelectionButton(_ sender: Any) {
        print("User 1 Button Selected")
        userOne.isSelected = true
        user1.isSelected = true
    }
    
    @IBAction func userTwoSelectionButton(_ sender: Any) {
        print("User 2 Button Selected")
        userTwo.isSelected = true
        user2.isSelected = true
    }
    
    
}

