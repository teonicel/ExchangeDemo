//
//  CurrencyListViewModel.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

public protocol CurrencyListNavigable {
    var goToSettings: (() -> Void)? { get set }
    var goToCurrencyHistory: (() -> Void)? { get set }
}

public protocol CurrencyListViewProtocol: AnyObject {
    var viewModel: CurrencyListViewModelProtocol? { get set }
    func updateView()
}

public protocol CurrencyListViewModelProtocol: ErrorViewable {
    var managedView: CurrencyListViewProtocol? { get set }
    var rate: Rate? { get set }
    func viewDidLoad()
    func rateSelected(indexPath: IndexPath)
    func settingsTapped()
    func chartsTapped()
}

final public class CurrencyListViewModel: CurrencyListViewModelProtocol {
    public var error: Error?
    public var rate: Rate? {
        didSet {
            managedView?.updateView()
        }
    }
    
    public weak var managedView: CurrencyListViewProtocol?
    
    private var navigation: CurrencyListNavigable
    
    init(navigation: CurrencyListNavigable) {
        self.navigation = navigation
    }
    
    public func viewDidLoad() {
        ExchangeConnection().getRates { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rate):
                    self?.rate = rate
                case .failure(let error):
                    self?.error = error
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
}
