//
//  Rating.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import SwiftyCaching

struct Rating {
    var rating: Float?
}

extension Rating: Cached {
    init?(map: CacheMap<RatingMO>) {
        
    }
    
    mutating func cache(map: CacheMap<RatingMO>) {
        rating <- map.bind { $0.rating }
    }
}
