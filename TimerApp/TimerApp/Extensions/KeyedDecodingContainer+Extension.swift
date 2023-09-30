//
//  KeyedDecodingContainer+Extension.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation

public extension KeyedDecodingContainer {
    /// Formatters should be ordered by priority: the first correct will be chosen
    func decodeDate(forKey key: Self.Key) throws -> Date? {
        let dateFormatter = DateFormatter()
        if let date = try? decode(Date.self, forKey: key) {
            return date
        }
        
        guard let stringDate = try decodeIfPresent(String.self, forKey: key), !stringDate.isEmpty else { return nil }
        guard let date = dateFormatter.date(from: stringDate) else {
            print("Can't format date from string: \(stringDate)")
            return nil
        }
        
        return date
    }
    
    func decodeAnObjectFromPossibleArray<T: Decodable>(forKey key: Self.Key) throws -> T {
        if let array = try? decode([T].self, forKey: key), let firstObject = array.first {
            return firstObject
        } else {
            return try decode(T.self, forKey: key)
        }
    }
}

public extension KeyedDecodingContainer where Key == StringCodingKey {
    
    func decode<T: Decodable>(_ key: String) throws -> T {
        try decode(T.self, forKey: StringCodingKey(named: key))
    }
    
    func decodeIfPresent<T: Decodable>(_ key: String) throws -> T? {
        try decodeIfPresent(T.self, forKey: StringCodingKey(named: key))
    }
}

public struct StringCodingKey: CodingKey {
    
    // MARK: - Public properties
    
    public let stringValue: String
    public var intValue: Int? { nil }
    
    // MARK: - Initialization
    
    public init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    public init?(intValue: Int) {
        return nil
    }
    
    public init(named name: String) {
        self.stringValue = name
    }
}

