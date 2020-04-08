//
//  File.swift
//  ExchangeDemoTests
//
//  Created by teo on 08/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

import XCTest
@testable import ExchangeDemo

final class DateFormatterExtensionsTests: XCTestCase {
    func testDateOnly() {
        XCTAssertTrue(DateFormatter.dateOnly.string(from: Date.mock)  == "2020-04-11")
    }
    
    func testDayMonth() {
        XCTAssertTrue(DateFormatter.dayMonth.string(from: Date.mock) == "11-04")
    }
}
