//
//  CollectionExtensionsTests.swift
//  ExchangeDemoTests
//
//  Created by teo on 08/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import XCTest
@testable import ExchangeDemo

final class CollectionExtensionsTests: XCTestCase {
    func testCollectionSafeIndex() {
        let collection = ["A", "B", "C", "D", "A", "B", "C", "A"]
        XCTAssertTrue(collection[safe: 2] == "C")
        XCTAssertTrue(collection[safe: 11] == nil)
    }
}
