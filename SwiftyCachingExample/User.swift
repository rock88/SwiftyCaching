//
//  User.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import Foundation
import SwiftyCaching

struct User {
    var name: String?
    var age: Int?
    var weight: Float?
    
    var date: Date?
    var data: Data?
    
    var bestBook: Book?
    
    var books: [Book]?
    
    var ratings: [Rating]?
}

extension User: Cached {
    init?(map: CacheMap<UserMO>) {
        
    }
    
    mutating func cache(map: CacheMap<UserMO>) {
        name <- map.bind { $0.name }
        age <- map.bind { $0.age }
        weight <- map.bind { $0.weight }
        
        date <- map.bind { $0.date }
        data <- map.bind { $0.data }
        
        bestBook <- map.bind { $0.bestBook }
        
        books <- map.bind { $0.books }
        
        ratings <- (map.bind { $0.ratings }, { (a: Rating, b: Rating) in a.rating! > b.rating! })
    }
}
