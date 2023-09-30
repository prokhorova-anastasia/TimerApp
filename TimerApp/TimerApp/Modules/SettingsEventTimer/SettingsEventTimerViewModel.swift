//
//  SettingsEventTimerViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation

final class SettingsEventTimerViewModel: ObservableObject {
    
    func saveEventTimer(title: String, description: String?, targetDate: Date) {
        let newEventTimer = EventTimer(title: title, description: description, targetDate: targetDate)
        if var array = UserDefaultsConfigurator.shared.getObjects(EventTimer.self, forKey: UserDefaultsKeys.eventTimer.rawValue), !array.isEmpty {
            array.append(newEventTimer)
            UserDefaultsConfigurator.shared.saveObjects(array, forKey: UserDefaultsKeys.eventTimer.rawValue)
        } else {
            UserDefaultsConfigurator.shared.saveObjects([newEventTimer], forKey: UserDefaultsKeys.eventTimer.rawValue)
        }
    }
    
    func updateEventTimer(eventTimer: EventTimer) {
        if var array = UserDefaultsConfigurator.shared.getObjects(EventTimer.self, forKey: UserDefaultsKeys.eventTimer.rawValue), !array.isEmpty {
            guard let index = array.firstIndex(where: {$0.id == eventTimer.id})  else { return }
            array.remove(at: index)
            array.append(eventTimer)
            UserDefaultsConfigurator.shared.saveObjects(array, forKey: UserDefaultsKeys.eventTimer.rawValue)
        }
    }
}
