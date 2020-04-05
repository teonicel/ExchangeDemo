//
//  CurrencyHistoryViewModel.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

public protocol CurrencyHistoryNavigable {
    var goBack: (() -> Void)? { get set }
}

public protocol CurrencyHistoryViewProtocol: AnyObject {
    var viewModel: CurrencyHistoryViewModelProtocol? { get set }
}

public protocol CurrencyHistoryViewModelProtocol {
    var managedView: CurrencyHistoryViewProtocol? { get set }
}

final public class CurrencyHistoryViewModel: CurrencyHistoryViewModelProtocol {
    public weak var managedView: CurrencyHistoryViewProtocol?
    
    private var navigation: CurrencyHistoryNavigable
    
    init(navigation: CurrencyHistoryNavigable) {
        self.navigation = navigation
    }
}
