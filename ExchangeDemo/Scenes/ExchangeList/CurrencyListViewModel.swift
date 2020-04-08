//
//  CurrencyListViewModel.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

public protocol CurrencyListNavigable: ErrorNavigable {
    var goToSettings: (() -> Void)? { get set }
    var goToCurrencyHistory: (() -> Void)? { get set }
}

public protocol CurrencyListViewProtocol: AnyObject {
    var viewModel: CurrencyListViewModelProtocol? { get set }
    func updateView()
}

public protocol CurrencyListViewModelProtocol {
    var managedView: CurrencyListViewProtocol? { get set }
    var rate: Rate? { get set }
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
    func rateSelected(indexPath: IndexPath)
    func settingsTapped()
    func chartsTapped()
}

final public class CurrencyListViewModel: CurrencyListViewModelProtocol {
    public var rate: Rate? {
        didSet {
            managedView?.updateView()
        }
    }
    
    public weak var managedView: CurrencyListViewProtocol?
    private var navigation: CurrencyListNavigable
    private var connection: ExchangeConnectionProtocol
    private var timer: Timer?
    
    init(connection: ExchangeConnectionProtocol, navigation: CurrencyListNavigable) {
        self.navigation = navigation
        self.connection = connection
    }
    
    public func viewDidLoad() {
        getData()
    }
    
    public func viewDidAppear() {
        getData()
    }
    
    public func viewDidDisappear() {
        timer?.invalidate()
    }
    
    @objc private func getData() {
        connection.getLatestRates(baseCurrency: Settings.baseCurrency) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rate):
                    self?.rate = rate
                    self?.startTimer()
                case .failure(let error):
                    self?.navigation.goToError?(error)
                }
            }
        }
    }
    
    public func rateSelected(indexPath: IndexPath) {
       
    }
    
    public func settingsTapped() {
        navigation.goToSettings?()
    }
    
    public func chartsTapped() {
        navigation.goToCurrencyHistory?()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: Settings.updateInterval.rawValue, target: self, selector: #selector(getData), userInfo: nil, repeats: false)
    }
    
    deinit {
        timer?.invalidate()
    }
}
