//
//  Result.swift
//  iOS Movie Night App
//
//  Created by Woodchuck on 11/15/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation




enum Result<T, U> where U: Error {
    case success(T)
    case failure(U) 
}

















