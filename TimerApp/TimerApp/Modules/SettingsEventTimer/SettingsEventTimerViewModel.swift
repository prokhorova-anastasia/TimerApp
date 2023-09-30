//
//  SettingsEventTimerViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation

final class SettingsEventTimerViewModel: ObservableObject {
    
    func saveEventTimer(title: String, description: String?, targetDate: Date) {
        UserDefaultsConfigurator.shared.saveBoolData(true, forKey: .wasTimerCreated)
        let newEventTimer = EventTimer(title: title, description: description, targetDate: targetDate)
        if var array = UserDefaultsConfigurator.shared.getObjects(EventTimer.self, forKey: .eventTimer), !array.isEmpty {
            array.append(newEventTimer)
            UserDefaultsConfigurator.shared.saveObjects(array, forKey: .eventTimer)
        } else {
            UserDefaultsConfigurator.shared.saveObjects([newEventTimer], forKey: .eventTimer)
        }
    }
    
    func updateEventTimer(eventTimer: EventTimer) {
        if var array = UserDefaultsConfigurator.shared.getObjects(EventTimer.self, forKey: .eventTimer), !array.isEmpty {
            guard let index = array.firstIndex(where: {$0.id == eventTimer.id})  else { return }
            array.remove(at: index)
            array.append(eventTimer)
            UserDefaultsConfigurator.shared.saveObjects(array, forKey: .eventTimer)
        }
    }
}
