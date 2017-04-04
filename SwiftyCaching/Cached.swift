//
//  Cached.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import CoreData

public protocol Cached {
    associatedtype T: NSManagedObject
    
    init?(map: CacheMap<T>)
    mutating func cache(map: CacheMap<T>)
}

public extension Cached {
    
    init?(managedObject: Self.T) {
        let mapper = CacheMap<Self.T>(managedObject: managedObject)
        if var mapped = Self(map: mapper) {
            mapped.cache(map: mapper)
            self = mapped
        } else {
            return nil
        }
    }
    
    func cache(managedObject: Self.T) {
        let mapper = CacheMap<Self.T>(managedObject: managedObject)
        mapper.fill = true
        
        var copy = self
        copy.cache(map: mapper)
    }
}
