//
//  GenreCell.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/20/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit





class GenreCell: UITableViewCell {
    
    static let reuseIdentifier = "GenreCell"
    
    @IBOutlet weak var genreNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with viewModel: GenreCellViewModel) {
        genreNameLabel.text = viewModel.name
    }
    
}



