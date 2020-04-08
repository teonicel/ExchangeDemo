//
//  DateExtensionsTests.swift
//  ExchangeDemoTests
//
//  Created by teo on 08/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

import XCTest
@testable import ExchangeDemo

final class DateExtensionsTests: XCTestCase {
    func testDateOnly() {
        XCTAssertTrue(Date.mock.dateOnly == "2020-04-11")
    }
    
    func testDayMonth() {
        XCTAssertTrue(Date.mock.dayMonth == "11-04")
    }
}
