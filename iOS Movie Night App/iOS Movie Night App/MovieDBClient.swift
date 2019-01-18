//
//  MovieDBClient.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/15/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation


class MovieDBClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
        
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //find common movies with all of these entities
    func getMovies(sortBy sortType: String = "popularity.desc", people: [People], genres: [Genre], completion: @escaping (Result<[Movie], APIError>) -> Void) {
        
        let endpoint = TheMovieDB.discover(sortBy: sortType, people: people, genres: genres)
        
        let request = endpoint.request // or requestWithAuthorizationHeader(oauthtoken: token)???
        
        fetch(with: request, parse: { (json) -> [Movie] in
            
            guard let movies = json["results"] as? [[String: Any]] else { return [] }
            
            return movies.flatMap { Movie(json: $0) }
        }, completion: completion)
        print(request)
    }
    
    //get movie genres
    func getGenres(completion: @escaping (Result<[Genre], APIError>) -> Void) {
        let endpoint = TheMovieDB.genre(genreList: .movieList)
        
        let request = endpoint.request // or requestWithAuthorizationHeader(oauthtoken: token)???
        
        fetch(with: request, parse: { (json) -> [Genre] in
            guard let genres = json["genres"] as? [[String: Any]] else { return [] }
            
            return genres.flatMap { Genre(json: $0) }
        }, completion: completion)
    
    }
    
    //get actors
    func getPeople(completion: @escaping (Result<[People], APIError>) -> Void) {
        let endpoint = TheMovieDB.person(peopleList: .peopleList)
        
        let request = endpoint.request // or requestWithAuthorizationHeader(oauthtoken: token)???
        
        fetch(with: request, parse: { (json) -> [People] in
            guard let peoples = json["results"] as? [[String: Any]] else { return [] }
            
            return peoples.flatMap { People(json: $0) }
        }, completion: completion)
    }
    
    //get production companies
    func getCompanies(with text: String?, completion: @escaping (Result<[Company], APIError>) -> Void) {
        let endpoint = TheMovieDB.search(searchList: .companies, text: text) //fix this endpoint!!!
        
        let request = endpoint.request // or requestWithAuthorizationHeader(oauthtoken: token)???
        
        fetch(with: request, parse: { (json) -> [Company] in
            guard let companies = json["results"] as? [[String: Any]] else { return [] }
            
            return companies.flatMap { Company(json: $0) }
        }, completion: completion)
    }
    
    
    
}







