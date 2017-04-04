//
//  Binder.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import CoreData

public struct Binder<T: NSManagedObject, U> {
    let cacheMap: CacheMap<T>
    let bind: (T) -> U?
}
