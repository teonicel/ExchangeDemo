//
//  SettingsViewModel.swift
//  ExchangeDemoTests
//
//  Created by teo on 08/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import XCTest
@testable import ExchangeDemo

final class SettingsViewModelTests: XCTestCase {
    var viewMock: SettingsViewMock?
    var viewModel: SettingsViewModel?
    var navigationMock: SettingsNavigationMock?
    var connectionMock: ExchangeConnectionMock?
    
    override func setUp() {
        super.setUp()
        navigationMock = SettingsNavigationMock()
        viewMock = SettingsViewMock()
        connectionMock = ExchangeConnectionMock()
        viewModel = SettingsViewModel(navigation: navigationMock!)
        viewMock?.viewModel = viewModel
        viewModel?.managedView = viewMock
        Settings.updateInterval = .fastest
        Settings.baseCurrency = .EUR
    }
    
    func testViewDidLoad() {
        XCTAssertTrue(viewMock?.viewWasUpdated == nil)
        XCTAssertTrue(viewModel?.currencies == [])
        XCTAssertTrue(viewModel?.selectedCurrencyIndex == 0)
        XCTAssertTrue(viewModel?.refreshRates == [])
        XCTAssertTrue(viewModel?.selectedRefreshIndex == 0)
        
        Settings.updateInterval = .fast
        Settings.baseCurrency = .USD
        viewModel?.viewDidLoad()
        
        XCTAssertTrue(viewMock?.viewWasUpdated == true)
        XCTAssertTrue(viewModel?.currencies == ["EUR", "CAD", "HKD", "ISK", "PHP", "DKK", "HUF", "CZK", "AUD", "RON", "SEK", "IDR", "INR", "BRL", "RUB", "HRK", "JPY", "THB", "CHF", "SGD", "PLN", "BGN", "TRY", "CNY", "NOK", "NZD", "ZAR", "USD", "MXN", "ILS", "GBP", "KRW", "MYR"])
        XCTAssertTrue(viewModel?.selectedCurrencyIndex == 27)
        XCTAssertTrue(viewModel?.refreshRates == [3, 5, 15])
        XCTAssertTrue(viewModel?.selectedRefreshIndex == 1)
    }
    
    func testRefreshTimeChanged() {
        XCTAssertTrue(Settings.updateInterval == .fastest)
        
        viewModel?.viewDidLoad()
        viewModel?.refreshTimeChanged(index: 2)
        
        XCTAssertTrue(Settings.updateInterval == .normal)
    }
    
    func testCurrencySelected() {
        XCTAssertTrue(Settings.baseCurrency == .EUR)
        
        viewModel?.viewDidLoad()
        viewModel?.currencySelected(index: 27)
        
        XCTAssertTrue(Settings.baseCurrency == .USD)
    }
}

final class SettingsViewMock: SettingsViewProtocol {
    var viewWasUpdated: Bool?
    var viewModel: SettingsViewModelProtocol?
    
    func updateView() {
        viewWasUpdated = true
    }
}

final class SettingsNavigationMock: SettingsNavigable {
    var wentBack: Bool?
    var goBack: (() -> Void)?
    
    init() {
        goBack = {
            self.wentBack = true
        }
    }
}
