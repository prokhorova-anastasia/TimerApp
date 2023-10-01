//
//  MainScreenViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import SwiftUI

final class MainScreenViewModel: ObservableObject {
    
    @Published var eventTimers: [EventTimer] = []
    
    init() {
        getEventTimers()
    }
    
    func getEventTimers() {
        eventTimers = UserDefaultsManager.shared.getObjects(EventTimer.self, forKey: .eventTimer) ?? []
    }
    
    func removeAllEventTimers() {
        UserDefaultsManager.shared.removeObject(forKey: .eventTimer)
        eventTimers = []
    }
    
    func removeEventTimer(event: EventTimer) {
        eventTimers.removeAll { eventTimer in
            eventTimer.id == event.id
        }
        UserDefaultsManager.shared.removeObject(forKey: .eventTimer)
        UserDefaultsManager.shared.saveObjects(eventTimers, forKey: .eventTimer)
    }
}
