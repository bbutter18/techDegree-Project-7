//
//  MovieCellViewModel.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/20/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit

struct MovieCellViewModel {
    let title: String
}

extension MovieCellViewModel {
    init(movie: Movie) {
        self.title = movie.title
    }
}
