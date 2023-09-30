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
        eventTimers = UserDefaultsConfigurator.shared.getObjects(EventTimer.self, forKey: .eventTimer) ?? []
    }
    
    func removeAllEventTimers() {
        UserDefaultsConfigurator.shared.removeObject(forKey: .eventTimer)
        eventTimers = []
    }
    
    func removeEventTimer(event: EventTimer) {
        eventTimers.removeAll { eventTimer in
            eventTimer.id == event.id
        }
        UserDefaultsConfigurator.shared.removeObject(forKey: .eventTimer)
        UserDefaultsConfigurator.shared.saveObjects(eventTimers, forKey: .eventTimer)
    }
}
