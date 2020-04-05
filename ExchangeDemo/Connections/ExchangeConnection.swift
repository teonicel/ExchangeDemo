//
//  ExchangeConnection.swift
//  Currency
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation
import Alamofire

final public class ExchangeConnection {
    public func getRates(completion: () -> Result<[Rate], Error>) {
        let urlString = "https://api.exchangeratesapi.io/latest"
        AF.request(urlString).responseDecodable(of: Rate.self) { response in
            debugPrint("Response: \(response)")
        }
    }
    
}

public struct Rate: Decodable {
    let rates: [[Currency: Decimal]]
    let base: Currency
    let date: Date
}

public enum Currency: String, Decodable {
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
