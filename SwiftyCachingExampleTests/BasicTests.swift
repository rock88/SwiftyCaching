//
//  BasicTests.swift
//  SwiftyCachingExampleTests
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import XCTest
@testable import SwiftyCaching
@testable import SwiftyCachingExample

class BasicTests: XCTestCase {
    let stack = CoreDataStack()
    
    let uname: String = "Test"
    let age: Int = 20
    let weight: Float = 100.5
    
    func testShouldCacheMO() {
        var user = User()
        user.name = uname
        user.age = age
        user.weight = weight
        
        let userMO: UserMO = stack.new()
        user.cache(managedObject: userMO)
        
        XCTAssertEqual(userMO.name, uname)
        XCTAssertEqual(userMO.age, Int32(age))
        XCTAssertEqual(userMO.weight, weight)
    }
    
    func testShouldCreateFromMO() {
        let userMO: UserMO = stack.new()
        userMO.name = uname
        userMO.age = Int32(age)
        userMO.weight = weight
        
        let user = User(managedObject: userMO)
        
        XCTAssertEqual(user?.name, uname)
        XCTAssertEqual(user?.age, age)
        XCTAssertEqual(user?.weight, weight)
    }
}
