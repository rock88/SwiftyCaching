//
//  NestedUnsortedArrayTests.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import XCTest
@testable import SwiftyCaching
@testable import SwiftyCachingExample

class NestedUnsortedArrayTests: XCTestCase {
    let stack = CoreDataStack()
    
    func testShouldCacheMO() {
        var user = User()
        user.books = [
            Book(name: "1"),
            Book(name: "2")
        ]
        
        let userMO: UserMO = stack.new()
        userMO.books = [
            stack.new() as BookMO,
            stack.new() as BookMO
        ]
        
        user.cache(managedObject: userMO)
        
        let books = userMO.books?.allObjects as? [BookMO]
        XCTAssertNotNil(books?.first { $0.name == "1" })
        XCTAssertNotNil(books?.first { $0.name == "2" })
    }
    
    func testShouldCreateFromMO() {
        let userMO: UserMO = stack.new()
        let bookMO1: BookMO = stack.new()
        bookMO1.name = "1"
        
        let bookMO2: BookMO = stack.new()
        bookMO2.name = "2"
        
        userMO.books = [bookMO1, bookMO2]
        
        let user = User(managedObject: userMO)
        
        XCTAssertNotNil(user?.books?.first { $0.name == "1" })
        XCTAssertNotNil(user?.books?.first { $0.name == "2" })
    }
}
