//
//  ExchangeConnection.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation
import Alamofire

public enum ExchangeError {
    case noData
    case decodingError
}

extension ExchangeError: Error {
    public var description: String {
        switch self {
        case .noData:
            return "No data available!"
        case .decodingError:
            return "Data decoding error!"
        }
    }
}

public protocol ExchangeConnectionProtocol {
    func getLatestRates(baseCurrency: Currency, completion: @escaping (Result<Rate, Error>) -> Void)
    func getRates(startDate: Date, endDate: Date, currencies: [Currency], completion: @escaping (Result<[CurrencyRecord], Error>) -> Void)
}

final public class ExchangeConnection: ExchangeConnectionProtocol {
    public var baseURLString = "https://api.exchangeratesapi.io"
    public func getLatestRates(baseCurrency: Currency, completion: @escaping (Result<Rate, Error>) -> Void) {
        let urlString = "\(baseURLString)/latest?base=\(baseCurrency.rawValue)"
        AF.request(urlString).responseData { (afData) in
            
            if let data = afData.data {
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(.dateOnly)
                    let decoded = try decoder.decode(Rate.self, from: data)
                    completion(.success(decoded))
                } catch{
                    completion(.failure(ExchangeError.decodingError))
                }
            } else {
                completion(.failure(ExchangeError.noData))
            }
        }
    }
    
    public func getRates(startDate: Date, endDate: Date, currencies: [Currency], completion: @escaping (Result<[CurrencyRecord], Error>) -> Void) {
        let start = startDate.dateOnly
        let end = endDate.dateOnly
        let symbols = currencies.map { $0.rawValue }.joined(separator: ",")
        let urlString = "\(baseURLString)/history?start_at=\(start)&end_at=\(end)&symbols=\(symbols)"
        AF.request(urlString).responseData { (afData) in
            
            if let data = afData.data {
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(.dateOnly)
                    let decoded = try decoder.decode(MultiRatePayload.self, from: data)
                    let df = DateFormatter.dateOnly
//                    var currencyChartDict = [Currency: [[Date: Decimal]]]()
                    var currencyRecords = [CurrencyRecord]()
                    for (k,v) in decoded.rates {
                        let date = df.date(from: k) ?? Date()
                        for (c, d) in v {
                            if let currency = Currency(rawValue: c) {
                                currencyRecords.append(CurrencyRecord(currency: currency,
                                                                      value: d,
                                                                      date: date))
                            }
                        }
                    }
                    
                    completion(.success(currencyRecords))
                } catch{
                    completion(.failure(ExchangeError.decodingError))
                }
            } else {
                completion(.failure(ExchangeError.noData))
            }
        }
    }
}

private struct MultiRatePayload: Decodable {
    let rates: [String: [String: Decimal]]
    let base: Currency
}

public struct CurrencyRecord {
    let currency: Currency
    let value: Decimal
    let date: Date
}

public struct Dummy {
    let a: String
    let b: Int
    let c: [String: String]
}

public struct Rate: Codable {
    let rates: [[Currency: Decimal]]
    let base: Currency
    let date: Date
    
    private enum CodingKeys: String, CodingKey {
        case rates
        case base
        case date
    }
    
    init(rates: [[Currency: Decimal]], base: Currency, date: Date) {
        self.rates = rates
        self.base = base
        self.date = date
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let ratesDict = try values.decode([String: Decimal].self, forKey: .rates)
        rates = ratesDict.map { [Currency(rawValue: $0.key) ?? .EUR: $0.value] }
        base = try values.decode(Currency.self, forKey: .base)
        date = try values.decode(Date.self, forKey: .date)
    }
}

public enum Currency: String, Codable, CaseIterable {
    case EUR
    case CAD
    case HKD
    case ISK
    case PHP
    case DKK
    case HUF
    case CZK
    case AUD
    case RON
    case SEK
    case IDR
    case INR
    case BRL
    case RUB
    case HRK
    case JPY
    case THB
    case CHF
    case SGD
    case PLN
    case BGN
    case TRY
    case CNY
    case NOK
    case NZD
    case ZAR
    case USD
    case MXN
    case ILS
    case GBP
    case KRW
    case MYR
}
