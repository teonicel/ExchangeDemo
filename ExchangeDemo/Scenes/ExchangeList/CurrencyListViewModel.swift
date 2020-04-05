//
//  CurrencyListViewModel.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation
import RxSwift

public protocol CurrencyListNavigable {
    var goToSettings: (() -> Void)? { get set }
    var goToCurrencyHistory: (() -> Void)? { get set }
}

public protocol CurrencyListViewProtocol: AnyObject {
    var viewModel: CurrencyListViewModelProtocol? { get set }
    func updateTable()
}

public protocol CurrencyListViewModelProtocol: ErrorViewable {
    var managedView: CurrencyListViewProtocol? { get set }
    var rate: Rate? { get set }
    func viewDidLoad()
    func rateSelected(indexPath: IndexPath)
    func settingsTapped()
}

final public class CurrencyListViewModel: CurrencyListViewModelProtocol {
    public var error = PublishSubject<Error>()
    public var rate: Rate? {
        didSet {
            managedView?.updateTable()
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
                    self?.error.onNext(error)
                }
            }
        }
    }
    
    public func rateSelected(indexPath: IndexPath) {
        navigation.goToCurrencyHistory?()
    }
    
    public func settingsTapped() {
        navigation.goToSettings?()
    }
}
