//
//  NestedSortedArrayTests.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import XCTest
@testable import SwiftyCaching
@testable import SwiftyCachingExample

class NestedSortedArrayTests: XCTestCase {
    let stack = CoreDataStack()
    
    let values: [Float] = [
        0.1,
        1.0,
        3.9,
        3.4,
        10.2
    ]
    
    func testShouldCacheMO() {
        var user = User()
        user.ratings = values.map { Rating(rating: $0) }
        
        let userMO: UserMO = stack.new()
        let array = values.map { _ in stack.new() as RatingMO }
        userMO.ratings = NSSet(array: array)
        
        user.cache(managedObject: userMO)
        
        let ratings = userMO.ratings?.allObjects as? [RatingMO]
        
        values.forEach { rating in
            XCTAssertNotNil(ratings?.first { $0.rating == rating })
        }
    }
    
//    func testShouldCreateFromMO() {
//        let userMO: UserMO = stack.new()
//        let array = values.map { _ in stack.new() as RatingMO }
//        
//        
//        userMO.books = [bookMO1, bookMO2]
//        
//        let user = User(managedObject: userMO)
//        
//        XCTAssertNotNil(user?.books?.first { $0.name == "1" })
//        XCTAssertNotNil(user?.books?.first { $0.name == "2" })
//    }
}
