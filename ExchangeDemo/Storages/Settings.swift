//
//  Settings.swift
//  ExchangeDemo
//
//  Created by teo on 05/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

final public class Settings {
    public static var updateInterval: TimeInterval {
        set {
            CodablePersistency.pack(object: newValue, key: "updateInterval")
        }
        get {
            return CodablePersistency.unpack(key: "updateInterval") ?? 3
        }
    }
    
    public static var baseCurrency: Currency {
        set {
            CodablePersistency.pack(object: newValue, key: "updateInterval")
        }
        get {
            return CodablePersistency.unpack(key: "updateInterval") ?? .EUR
        }
    }
}
