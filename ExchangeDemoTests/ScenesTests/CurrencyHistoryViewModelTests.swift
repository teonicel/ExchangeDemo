//
//  Excg.swift
//  ExchangeDemoTests
//
//  Created by teo on 08/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import XCTest
@testable import ExchangeDemo

final class CurrencyHistoryViewModelTests: XCTestCase {
    var viewMock: CurrencyHistoryViewMock?
    var viewModel: CurrencyHistoryViewModel?
    var navigationMock: CurrencyHistoryNavigationMock?
    var connectionMock: ExchangeConnectionMock?
    
    override func setUp() {
        super.setUp()
        navigationMock = CurrencyHistoryNavigationMock()
        viewMock = CurrencyHistoryViewMock()
        connectionMock = ExchangeConnectionMock()
        viewModel = CurrencyHistoryViewModel(connection: connectionMock!, navigation: navigationMock!)
        viewMock?.viewModel = viewModel
        viewModel?.managedView = viewMock
        
    }
    
    func testGetDataSuccess() {
        XCTAssertTrue(viewModel?.currencies == [])
        XCTAssertTrue(viewModel?.chartData(for: .USD) == nil)
        viewModel?.viewDidLoad()
        
        let exp = expectation(description: "Test after 1 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(viewModel?.currencies == [Currency.USD])
            XCTAssertTrue(viewModel?.chartData(for: .USD)?.chartSeries.data[0].x == 0)
            XCTAssertTrue(viewModel?.chartData(for: .USD)?.chartSeries.data[0].y == 100)
            XCTAssertTrue(viewModel?.chartData(for: .USD)?.labels == [Date.mock.dayMonth])
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testGetDataFail() {
        XCTAssertTrue(viewModel?.currencies == [])
        XCTAssertTrue(viewModel?.chartData(for: .USD) == nil)
        connectionMock?.isError = true
        viewModel?.viewDidLoad()
        
        let exp = expectation(description: "Test after 1 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(viewModel?.currencies == [])
            XCTAssertTrue(viewModel?.chartData(for: .EUR) == nil)
            XCTAssertTrue(navigationMock?.gotError != nil)
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

final class CurrencyHistoryViewMock: CurrencyHistoryViewProtocol {
    var viewWasUpdated: Bool?
    var viewModel: CurrencyHistoryViewModelProtocol?
    
    func updateView() {
        viewWasUpdated = true
    }
}

final class CurrencyHistoryNavigationMock: CurrencyHistoryNavigable {
    var wentBack: Bool?
    var gotError: Error?
    
    var goBack: (() -> Void)?
    var goToError: ((Error) -> Void)?
    
    init() {
        goBack = {
            self.wentBack = true
        }
        
        goToError = { error in
            self.gotError = error
        }
    }
}
