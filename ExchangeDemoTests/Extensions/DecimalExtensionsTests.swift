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

final class DecimalExtensionsTests: XCTestCase {
    let decimal = Decimal(floatLiteral: 10.121121212)
    
    func testTwoDigitsString() {
        XCTAssertTrue(decimal.twoDigitsString == "10.12")
    }
    
    func testDoubleValue() {
        XCTAssertTrue(decimal.doubleValue == 10.121121212000002)
    }
}
