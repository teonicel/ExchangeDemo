//
//  CurrencyHistoryViewModel.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

public protocol CurrencyHistoryNavigable: ErrorNavigable {
    var goBack: (() -> Void)? { get set }
}

public protocol CurrencyHistoryViewProtocol: AnyObject {
    var viewModel: CurrencyHistoryViewModelProtocol? { get set }
    func updateView()
}

public protocol CurrencyHistoryViewModelProtocol {
    var managedView: CurrencyHistoryViewProtocol? { get set }
    var charts: [ChartSeries]? { get set }
    func viewDidLoad()
}

final public class CurrencyHistoryViewModel: CurrencyHistoryViewModelProtocol {
    public var charts: [ChartSeries]? {
        didSet {
            managedView?.updateView()
        }
    }
    
    public weak var managedView: CurrencyHistoryViewProtocol?
    
    private var navigation: CurrencyHistoryNavigable
    
    init(navigation: CurrencyHistoryNavigable) {
        self.navigation = navigation
    }
    
    public func viewDidLoad() {
        getData()
    }
    
    private func getData() {
        charts = [
            ChartSeries([3, 2, 1, 6, 5, 4, 9, 8, 7, 1]),
            ChartSeries([3, 2, 1, 6, 7, 1, 5, 4, 9, 8]),
            ChartSeries([3, 5, 4, 9, 8, 7, 1, 2, 1, 6])
        ]
        
//        ExchangeConnection().getRates { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let rate):
//                    self?.rate = rate
//                case .failure(let error):
//                    self?.navigation.goToError?(error)
//                }
//            }
//        }
    }
}
