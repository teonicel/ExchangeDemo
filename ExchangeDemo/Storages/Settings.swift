//
//  Settings.swift
//  ExchangeDemo
//
//  Created by teo on 05/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

final public class Settings {
    public static var updateInterval: UpdateInterval {
        set {
            CodablePersistency.pack(object: newValue, key: "updateInterval")
        }
        get {
            return CodablePersistency.unpack(key: "updateInterval") ?? .fastest
        }
    }
    
    public static var baseCurrency: Currency {
        set {
            CodablePersistency.pack(object: newValue, key: "baseCurrency")
        }
        get {
            return CodablePersistency.unpack(key: "baseCurrency") ?? .EUR
        }
    }
}

public enum UpdateInterval: TimeInterval, Codable, CaseIterable {
    case fastest = 3
    case fast = 5
    case normal = 15
}
