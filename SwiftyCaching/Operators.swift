//
//  Operators.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import Foundation

infix operator <-: AssignmentPrecedence

public func <- <T, U>(left: inout U?, right: Binder<T, U>) {
    right.cacheMap.bind(&left) { right.bind($0) }
}

public func <- <T, U: Integer, V: Integer>(left: inout U?, right: Binder<T, V>) {
    right.cacheMap.bind(&left) { right.bind($0) }
}

public func <- <T, U: ReferenceConvertible>(left: inout U?, right: Binder<T, U.ReferenceType>) {
    right.cacheMap.bind(&left) { right.bind($0) }
}

public func <- <T, U: Cached>(left: inout U?, right: Binder<T, U.T>) {
    right.cacheMap.bind(&left) { right.bind($0) }
}

public func <- <T, U: Cached>(left: inout [U]?, right: Binder<T, NSSet>) {
    right.cacheMap.bindCollection(&left) { right.bind($0) }
}

public func <- <T, U: Cached>(left: inout [U]?, right: (Binder<T, NSSet>, (U, U) -> Bool)) {
    right.0.cacheMap.bindCollection(&left, { right.0.bind($0) }, right.1)
}
