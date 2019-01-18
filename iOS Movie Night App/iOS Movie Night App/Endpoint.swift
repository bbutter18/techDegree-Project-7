//
//  Endpoint.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/15/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation

protocol Endpoint {

    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    /// Returns an instance of URLComponents containing the base URL, path and
    /// query items provided
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    /// Returns an instance of URLRequest encapsulating the endpoint URL. This
    /// URL is obtained through the `urlComponents` object.
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
        
    }
    
    
    //INSERT **********request oAuth token? request with Authorization header?************
}


enum GenreEndpoint: CustomStringConvertible {
    case movieList
    
    var description: String {
        switch self {
        case .movieList: return "movie/list"
        }
    }
}

enum PeopleEndpoint: CustomStringConvertible {
    case peopleList
    
    var description: String {
        switch self {
        case .peopleList: return "popular"
        }
    }
}
    
    
enum SearchEndpoint: CustomStringConvertible {
    case movies
    case companies
    
    var description: String {
        switch self {
        case .movies: return "movie"
        case .companies: return "company"
        }
    }
}


enum TheMovieDB {
 
    case discover(sortBy: String, people: [People], genres: [Genre])
    case person(peopleList: PeopleEndpoint)
    case genre(genreList: GenreEndpoint)
    //case company(companyID: String)
    case search(searchList: SearchEndpoint, text: String?)
}

extension TheMovieDB: Endpoint {
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    
    var path: String {
        switch self {
        case .discover: return "/3/discover/movie"
        case .person(let peopleList): return "/3/person/\(peopleList.description)"
        case .genre(let genreList): return "/3/genre/\(genreList.description)"
        //case .company(let companyID): return "/3/search/company/\(companyID)" //*******work on this endpoint
        case .search(let searchList, let _): return "/3/search/\(searchList.description)" //******work on this endpoint
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .discover(let sortBy, let people, let genres):

            return [
                URLQueryItem(name: "api_key", value: APIKey.apiKey),
                //URLQueryItem(name: "language", value: language), //language.description instead?
                //URLQueryItem(name: "region", value: region),
                URLQueryItem(name: "sort_by", value: sortBy),
                //URLQueryItem(name: "include_adult", value: adultContent),
                //URLQueryItem(name: "include_video", value: videoContent),
                URLQueryItem(name: "with_people", value: people.map({$0.id.description}).joined(separator: ",")),
                URLQueryItem(name: "with_genres", value: genres.map({$0.id.description}).joined(separator: ","))
                //URLQueryItem(name: "with_companies", value: companyArray.joined(separator: "|"))
            
        ]
            //does not listing a specific value just bring up the entire list of actors in their database?
            //you should be able to search for a specific actor also and click on them and then search for another one or just proceed with the single selection
        case .person: return [URLQueryItem(name: "api_key", value: APIKey.apiKey)]
        
        case .genre: return [URLQueryItem(name: "api_key", value: APIKey.apiKey)]
        //case .company: return [URLQueryItem(name: "api_key", value: APIKey.apiKey)]
        case .search:
            return [URLQueryItem(name: "api_key", value: APIKey.apiKey)]
            //text is the inputted text in the text field for the search bar
           // URLQueryItem(name: "query", value: text)]
        
        }
    }
}


























