//
//  CodablePersistency.swift
//  ExchangeDemo
//
//  Created by teo on 05/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

final public class CodablePersistency {
    static func pack<T: Codable>(object: T, key: String) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            UserDefaults.standard.set(encoded, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func pack<T: Codable>(object: [T], key: String) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            UserDefaults.standard.set(encoded, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func unpack<T: Codable>(key: String) -> T? {
        
        if let jsonData = UserDefaults.standard.value(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let object: T = try? decoder.decode(T.self, from: jsonData) as T {
                return object
            }
        }
        return nil
    }
    
    static func unpackList<T: Codable>(key: String) -> [T]? {
        
        var response: [T]? = nil
        if let jsonData = UserDefaults.standard.value(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let object: [T] = try? decoder.decode([T].self, from: jsonData) as [T] {
                response = object
            }
        }
        return response
    }
    
    static func expire(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
