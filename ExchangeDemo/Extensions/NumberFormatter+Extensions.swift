//
//  NumberFormatter+Extensions.swift
//  ExchangeDemo
//
//  Created by teo on 03/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    private(set) static var currency: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.fractionDigits = 2
        return numberFormatter
    }()
    
    public var fractionDigits: Int {
        get {
            return minimumFractionDigits
        }
        set {
            minimumFractionDigits = newValue
            maximumFractionDigits = newValue
        }
    }
}
