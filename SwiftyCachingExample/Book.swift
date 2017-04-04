//
//  Book.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import SwiftyCaching

struct Book {
    var name: String?
}

extension Book: Cached {
    init?(map: CacheMap<BookMO>) {
        
    }
    
    mutating func cache(map: CacheMap<BookMO>) {
        name <- map.bind { $0.name }
    }
}
