//
//  GenreCellViewModel.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/20/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit




struct GenreCellViewModel {
    let name: String
}

extension GenreCellViewModel {
    init(genre: Genre) {
        self.name = genre.name
    }
}


