//
//  UserDefaultsConfigurator.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation

enum UserDefaultsKeys: String {
    case eventTimer = "EventTimers"
}

final class UserDefaultsConfigurator {
    
    static let shared = UserDefaultsConfigurator()
    
    private let defaults = UserDefaults.standard
    
    // Сохранение JSON-объекта
    func saveObject<T: Codable>(_ object: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(object)
            defaults.set(encodedData, forKey: key)
        } catch {
            print("Ошибка при кодировании объекта: \(error)")
        }
    }
    
    // Получение JSON-объекта
    func getObject<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        if let savedData = defaults.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(type, from: savedData)
                return object
            } catch {
                print("Ошибка при декодировании объекта: \(error)")
                return nil
            }
        }
        return nil
    }
    
    // Сохранение массива JSON-объектов
    func saveObjects<T: Codable>(_ objects: [T?], forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(objects)
            defaults.set(encodedData, forKey: key)
        } catch {
            print("Ошибка при кодировании массива объектов: \(error)")
        }
    }
    
    // Получение массива JSON-объектов
    func getObjects<T: Codable>(_ type: T.Type, forKey key: String) -> [T]? {
        if let savedData = defaults.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let objects = try decoder.decode([T].self, from: savedData)
                return objects
            } catch {
                print("Ошибка при декодировании массива объектов: \(error)")
                return nil
            }
        }
        return nil
    }
    
    func removeObject(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
