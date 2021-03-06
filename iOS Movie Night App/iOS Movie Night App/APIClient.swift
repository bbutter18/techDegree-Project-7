//
//  APIClient.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/15/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIClient {

    var session: URLSession { get }
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], APIError>) -> Void)
    
}

extension APIClient {
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, APIError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
       
        let task = session.dataTask(with: request) { data, response, error in
            
            //Display Alerts for No Internet Connection
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    let alert = UIAlertController(title: "Error", message: "No Internet Connection Available", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    alert.presentInWindow(animated: true, completion: nil)
                case .networkConnectionLost:
                    let alert = UIAlertController(title: "Error", message: "Internet Connection Lost", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    alert.presentInWindow(animated: true, completion: nil)
                default: break
                }
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = jsonTask(with: request) { json, error in
            
            //at this point we're done with any work in a background queue so we can switch to the main queue to continue.
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    
                    return
                }
                
                //success case
                if let value = parse(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        
        
        task.resume()
    }
    
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], APIError>) -> Void) {
        
        let task = jsonTask(with: request) { json, error in
            
            //at this point we're done with any work in a background queue so we can switch to the main queue to continue.
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    
                    return
                }
                
                //success case
                let value = parse(json)
                
                if !value.isEmpty {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        
        
        task.resume()
    }
}
































