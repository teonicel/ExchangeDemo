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

public typealias ChartData = (chartSeries: ChartSeries, labels: [String])

public protocol CurrencyHistoryViewModelProtocol {
    var managedView: CurrencyHistoryViewProtocol? { get set }
    var currencies: [Currency] { get }
    func chartData(for currency: Currency) -> ChartData?
    func viewDidLoad()
}

final public class CurrencyHistoryViewModel: CurrencyHistoryViewModelProtocol {
    public var currencies: [Currency] {
        return recordsMap.map { $0.key }
    }
    
    public func chartData(for currency: Currency) -> ChartData? {
        recordsMap[currency]
    }
    
    private var recordsMap = [Currency: ChartData]() {
        didSet {
            managedView?.updateView()
        }
    }
    
    public weak var managedView: CurrencyHistoryViewProtocol?
    private var navigation: CurrencyHistoryNavigable
    private var connection: ExchangeConnectionProtocol
    
    init(connection: ExchangeConnectionProtocol, navigation: CurrencyHistoryNavigable) {
        self.navigation = navigation
        self.connection = connection
    }
    
    public func viewDidLoad() {
        getData()
    }
    
    private func getData() {
        let cal = Calendar.current
        let date = cal.startOfDay(for: Date())
        var dates = [date]
        if let newDate = cal.date(byAdding: .day, value: -9, to: date) {
            dates.append(newDate)
        }
        
        connection.getRates(startDate: dates.last ?? Date(),
                                      endDate:  dates.first ?? Date(),
                                      currencies: [.BGN, .RON, .USD]) { [weak self] result in
                                        switch result {
                                        case .success(let records):
                                            guard let parsed = self?.parse(records: records) else { return }
                                            DispatchQueue.main.async {
                                                self?.recordsMap = parsed
                                            }
                                        case .failure(let error):
                                            DispatchQueue.main.async {
                                                self?.navigation.goToError?(error)
                                            }
                                        }
        }
    }
    
    private func parse(records: [CurrencyRecord]) ->  [Currency: (ChartSeries, [String])] {
        let currencies = records.map { $0.currency }.unique
        var recordMaps = [Currency: ChartData]()
        for currency in currencies {
            let filteredSorted = records.filter { $0.currency == currency}.sorted(by: { $0.date < $1.date })
            let chartSeries = ChartSeries(filteredSorted.map { $0.value.doubleValue })
            let labels = filteredSorted.map { $0.date.dayMonth }
            recordMaps[currency] = (chartSeries, labels)
        }
        return recordMaps
    }
}
