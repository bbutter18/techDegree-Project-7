//
//  Genre.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/15/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation



struct Genre {
    let id: Int
    let name: String
    var selected = false
}


extension Genre: JSONDecodable {
    init?(json: [String : Any]) {
        struct Key {
            static let id = "id"
            static let name = "name"
        }
        
        guard let idValue = json[Key.id] as? Int,
            let nameValue = json[Key.name] as? String else {
                return nil
        }
        
        self.id = idValue
        self.name = nameValue
    }
}




























