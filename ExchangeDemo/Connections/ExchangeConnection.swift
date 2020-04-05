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

final public class ExchangeConnection {
    public func getRates(completion: @escaping (Result<Rate, Error>) -> Void) {
        let urlString = "https://api.exchangeratesapi.io/latest"
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
}

public struct Rate: Decodable {
    let rates: [[Currency: Decimal]]
    let base: Currency
    let date: Date
    
    private enum CodingKeys: String, CodingKey {
        case rates
        case base
        case date
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let ratesDict = try values.decode([String: Decimal].self, forKey: .rates)
        rates = ratesDict.map { [Currency(rawValue: $0.key) ?? .EUR: $0.value] }
        base = try values.decode(Currency.self, forKey: .base)
        date = try values.decode(Date.self, forKey: .date)
    }
}

public enum Currency: String, Decodable {
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
