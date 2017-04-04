//
//  NestedTests.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import XCTest
@testable import SwiftyCaching
@testable import SwiftyCachingExample

class NestedTests: XCTestCase {
    let stack = CoreDataStack()
    
    let bookName: String = "test"
    
    func testShouldCacheMO() {
        var user = User()
        user.bestBook = Book()
        user.bestBook?.name = bookName
        
        let userMO: UserMO = stack.new()
        userMO.bestBook = stack.new()
        
        user.cache(managedObject: userMO)
        
        XCTAssertEqual(userMO.bestBook?.name, bookName)
    }
    
    func testShouldCreateFromMO() {
        let userMO: UserMO = stack.new()
        userMO.bestBook = stack.new()
        userMO.bestBook?.name = bookName
        
        let user = User(managedObject: userMO)
        
        XCTAssertEqual(user?.bestBook?.name, bookName)
    }
}
