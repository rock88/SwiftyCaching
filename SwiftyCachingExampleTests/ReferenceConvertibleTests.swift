//
//  ReferenceConvertibleTests.swift
//  SwiftyCaching
//
//  Created by rock88 on 04/04/2017.
//  Copyright © 2017 rock88. All rights reserved.
//

import XCTest
@testable import SwiftyCaching
@testable import SwiftyCachingExample

class ReferenceConvertibleTests: XCTestCase {
    let stack = CoreDataStack()
    
    let date: Date = Date()
    let data: Data = "data".data(using: .utf8) as Data!
    
    func testShouldCacheMO() {
        var user = User()
        user.date = date
        user.data = data
        
        let userMO: UserMO = stack.new()
        user.cache(managedObject: userMO)
        
        XCTAssertEqual(userMO.date, date as NSDate)
        XCTAssertEqual(userMO.data, data as NSData)
    }
    
    func testShouldCreateFromMO() {
        let userMO: UserMO = stack.new()
        userMO.date = date as NSDate
        userMO.data = data as NSData
        
        let user = User(managedObject: userMO)
        
        XCTAssertEqual(user?.date, date)
        XCTAssertEqual(user?.data, data)
    }
}
