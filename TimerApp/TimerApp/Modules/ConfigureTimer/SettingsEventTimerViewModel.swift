//
//  SettingsEventTimerViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation

final class SettingsEventTimerViewModel: ObservableObject {
    
    func saveEventTimer(title: String, description: String?, targetDate: Date, colorBackground: String?, imageName: String?) {
        UserDefaultsManager.shared.saveBoolData(true, forKey: .wasTimerCreated)
        let newEventTimer = EventTimer(title: title, description: description, targetDate: targetDate, colorBackground: colorBackground, photoName: imageName)
        if var array = UserDefaultsManager.shared.getObjects(EventTimer.self, forKey: .eventTimer), !array.isEmpty {
            array.append(newEventTimer)
            UserDefaultsManager.shared.saveObjects(array, forKey: .eventTimer)
        } else {
            UserDefaultsManager.shared.saveObjects([newEventTimer], forKey: .eventTimer)
        }
    }
    
    func updateEventTimer(eventTimer: EventTimer) {
        if var array = UserDefaultsManager.shared.getObjects(EventTimer.self, forKey: .eventTimer), !array.isEmpty {
            guard let index = array.firstIndex(where: {$0.id == eventTimer.id})  else { return }
            array.remove(at: index)
            array.append(eventTimer)
            UserDefaultsManager.shared.saveObjects(array, forKey: .eventTimer)
        }
    }
}
