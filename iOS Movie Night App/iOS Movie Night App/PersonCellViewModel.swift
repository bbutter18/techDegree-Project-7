//
//  PersonCellViewModel.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/20/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit



struct PersonCellViewModel {
    let name: String
}

extension PersonCellViewModel {
    init(person: People) {
        self.name = person.name
    }
}
