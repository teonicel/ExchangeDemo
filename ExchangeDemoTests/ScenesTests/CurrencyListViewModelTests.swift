//
//  CurrencyListViewModelTests.swift
//  ExchangeDemoTests
//
//  Created by teo on 07/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import XCTest
@testable import ExchangeDemo

final class CurrencyListViewModelTests: XCTestCase {
    var viewMock: CurrencyListViewMock?
    var viewModel: CurrencyListViewModel?
    var navigationMock: CurrencyListNavigationMock?
    var connectionMock: ExchangeConnectionMock?
    
    override func setUp() {
        super.setUp()
        navigationMock = CurrencyListNavigationMock()
        viewMock = CurrencyListViewMock()
        connectionMock = ExchangeConnectionMock()
        viewModel = CurrencyListViewModel(connection: connectionMock!, navigation: navigationMock!)
        viewMock?.viewModel = viewModel
        viewModel?.managedView = viewMock
        
    }
    
    func testGetDataSuccess() {
        XCTAssertTrue(viewModel?.rate == nil)
        viewModel?.viewDidLoad()
        
        let exp = expectation(description: "Test after 1 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(viewModel?.rate?.rates == Rate.mock.rates)
            XCTAssertTrue(viewModel?.rate?.base == Rate.mock.base)
            XCTAssertTrue(viewModel?.rate?.date == Rate.mock.date)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testGetDataFail() {
        XCTAssertTrue(viewModel?.rate == nil)
        connectionMock?.isError = true
        viewModel?.viewDidLoad()
        
        let exp = expectation(description: "Test after 1 second")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(viewModel?.rate == nil)
            XCTAssertTrue(navigationMock?.gotError != nil)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testSettingsTapped() {
        XCTAssertTrue(navigationMock?.wentToSettings == nil)
        viewModel?.settingsTapped()
        XCTAssertTrue(navigationMock?.wentToSettings == true)
    }
    
    func testChartsTapped() {
        XCTAssertTrue(navigationMock?.wentToSettings == nil)
        viewModel?.chartsTapped()
        XCTAssertTrue(navigationMock?.wentToCurrencyHistory == true)
    }
}

final class CurrencyListViewMock: CurrencyListViewProtocol {
    var viewWasUpdated: Bool?
    
    var viewModel: CurrencyListViewModelProtocol?
    
    func updateView() {
        viewWasUpdated = true
    }
}

final class CurrencyListNavigationMock: CurrencyListNavigable {
    var wentToSettings: Bool?
    var wentToCurrencyHistory: Bool?
    var gotError: Error?
    
    var goToSettings: (() -> Void)?
    
    var goToCurrencyHistory: (() -> Void)?
    
    var goToError: ((Error) -> Void)?
    
    init() {
        goToSettings = {
            self.wentToSettings = true
        }
        
        goToCurrencyHistory = {
            self.wentToCurrencyHistory = true
        }
        
        goToError = { error in
            self.gotError = error
        }
    }
}
