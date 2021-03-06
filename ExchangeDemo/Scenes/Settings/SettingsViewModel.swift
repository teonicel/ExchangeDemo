//
//  SettingsViewModel.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

public protocol SettingsNavigable {
    var goBack: (() -> Void)? { get set }
}

public protocol SettingsViewProtocol: AnyObject {
    var viewModel: SettingsViewModelProtocol? { get set }
    func updateView()
}

public protocol SettingsViewModelProtocol {
    var managedView: SettingsViewProtocol? { get set }
    var currencies: [String] { get set }
    var selectedCurrencyIndex: Int { get set }
    var refreshRates: [TimeInterval] { get set }
    var selectedRefreshIndex: Int { get set }
    func viewDidLoad()
    func refreshTimeChanged(index: Int)
    func currencySelected(index: Int)
}

final public class SettingsViewModel: SettingsViewModelProtocol {
    
    public weak var managedView: SettingsViewProtocol?
    public var currencies = [String]()
    public var selectedCurrencyIndex: Int = 0
    public var refreshRates = [TimeInterval]()
    public var selectedRefreshIndex: Int = 0
    private var navigation: SettingsNavigable
    
    init(navigation: SettingsNavigable) {
        self.navigation = navigation
    }
    
    public func viewDidLoad() {
        refreshRates = UpdateInterval.allCases.map { $0.rawValue }
        currencies = Currency.allCases.map { $0.rawValue }
        selectedRefreshIndex = refreshRates.firstIndex(of: Settings.updateInterval.rawValue) ?? 0
        selectedCurrencyIndex = currencies.firstIndex(of: Settings.baseCurrency.rawValue) ?? 0
        managedView?.updateView()
    }
    
    public func refreshTimeChanged(index: Int) {
        Settings.updateInterval = UpdateInterval(rawValue: refreshRates[safe: index] ?? 0) ?? .fastest
    }
    
    public func currencySelected(index: Int) {
        Settings.baseCurrency = Currency(rawValue: currencies[safe: index] ?? "") ?? .EUR
    }
}
