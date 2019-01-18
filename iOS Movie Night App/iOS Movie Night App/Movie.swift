//
//  Movie.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/15/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation


struct Movie {
    let title: String
    let id: Int
    let posterImageURL: URL
    let overview: String
    let releaseDate: String
}

extension Movie: JSONDecodable {
    init?(json: [String : Any]) {
        struct Key {
            static let id = "id"
            static let title = "title"
            static let posterImageURL = "poster_path"
            static let overview = "overview"
            static let releaseDate = "release_date"
        }
        
        guard let idValue = json[Key.id] as? Int,
            let titleValue = json[Key.title] as? String,
            let posterImageValue = json[Key.posterImageURL] as? String,
            let overviewValue = json[Key.overview] as? String,
           let releaseDateValue = json[Key.releaseDate] as? String else {
                return nil
        }
        
        self.id = idValue
        self.title = titleValue
        self.overview = overviewValue
        self.releaseDate = releaseDateValue
        
        //work on this implementation
        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(posterImageValue)") {
            self.posterImageURL = imageURL
        } else {
           return nil
        }
    }
}













