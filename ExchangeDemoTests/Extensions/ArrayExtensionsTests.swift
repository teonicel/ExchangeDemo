//
//  ArrayExtensionsTests.swift
//  ExchangeDemoTests
//
//  Created by teo on 08/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import XCTest
@testable import ExchangeDemo

final class ArrayExtensionsTests: XCTestCase {
    func testArrayUnique() {
        let array = ["A", "B", "C", "D", "A", "B", "C", "A"]
        let unique = array.unique
        XCTAssertTrue(unique == ["A", "B", "C", "D"])
    }
}
