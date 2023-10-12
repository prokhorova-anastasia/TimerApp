//
//  UserDefaultsConfigurator.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation

enum UserDefaultsKeys: String {
    case eventTimer = "EventTimers"
    case wasTimerCreated = "wasTimerCreated" 
}

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    func saveBoolData(_ data: Bool, forKey key: UserDefaultsKeys) {
        defaults.set(data, forKey: key.rawValue)
    }
    
    func getBoolData(forKey key: UserDefaultsKeys) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
    
    func saveData(_ data: Any, forKey key: UserDefaultsKeys) {
        defaults.set(data, forKey: key.rawValue)
    }
    
    func getData(forKey key: UserDefaultsKeys) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    
    // Сохранение JSON-объекта
    func saveObject<T: Codable>(_ object: T, forKey key: UserDefaultsKeys) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(object)
            defaults.set(encodedData, forKey: key.rawValue)
        } catch {
            print("Ошибка при кодировании объекта: \(error)")
        }
    }
    
    // Получение JSON-объекта
    func getObject<T: Codable>(_ type: T.Type, forKey key: UserDefaultsKeys) -> T? {
        if let savedData = defaults.data(forKey: key.rawValue) {
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
    func saveObjects<T: Codable>(_ objects: [T?], forKey key: UserDefaultsKeys) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(objects)
            defaults.set(encodedData, forKey: key.rawValue)
        } catch {
            print("Ошибка при кодировании массива объектов: \(error)")
        }
    }
    
    // Получение массива JSON-объектов
    func getObjects<T: Codable>(_ type: T.Type, forKey key: UserDefaultsKeys) -> [T]? {
        if let savedData = defaults.data(forKey: key.rawValue) {
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
    
    func removeObject(forKey key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func clearAll() {
            if let appDomain = Bundle.main.bundleIdentifier {
                defaults.removePersistentDomain(forName: appDomain)
            }
        }
}
