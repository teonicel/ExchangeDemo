//
//  ExchangeConnectionMock.swift
//  ExchangeDemoTests
//
//  Created by teo on 08/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation
@testable import ExchangeDemo

final class ExchangeConnectionMock: ExchangeConnectionProtocol {
    var isError = false
    
    func getLatestRates(baseCurrency: Currency, completion: @escaping (Result<Rate, Error>) -> Void) {
        if isError {
            completion(.failure(ExchangeError.noData))
        } else {
            completion(.success(Rate.mock))
        }
    }
    
    func getRates(startDate: Date, endDate: Date, currencies: [Currency], completion: @escaping (Result<[CurrencyRecord], Error>) -> Void) {
        if isError {
            completion(.failure(ExchangeError.noData))
        } else {
            completion(.success([CurrencyRecord.mock]))
        }
    }
}

extension Rate {
    static var mock: Rate {
        return Rate(rates: [[.USD: 100]], base: Currency.USD, date: Date.mock)
    }
}

extension CurrencyRecord {
    static var mock: CurrencyRecord {
        return CurrencyRecord(currency: .USD, value: 100, date: Date.mock)
    }
}

extension Date {
    static var mock: Date {
        return DateFormatter.dateOnly.date(from: "2020-04-11") ?? Date()
    }
}
