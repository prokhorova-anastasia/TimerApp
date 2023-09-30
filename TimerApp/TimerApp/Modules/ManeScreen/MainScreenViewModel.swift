//
//  MainScreenViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import SwiftUI

final class MainScreenViewModel: ObservableObject {
    
    private enum Constants {
        static let userDefaultsKeyEventTimers = UserDefaultsKeys.eventTimer.rawValue
    }
    
    @Published var eventTimers: [EventTimer] = []
    
    init() {
        getEventTimers()
    }
    
    func getEventTimers() {
        eventTimers = UserDefaultsConfigurator.shared.getObjects(EventTimer.self, forKey: Constants.userDefaultsKeyEventTimers) ?? []
    }
    
    func removeAllEventTimers() {
        UserDefaultsConfigurator.shared.removeObject(forKey: Constants.userDefaultsKeyEventTimers)
        eventTimers = []
    }
    
    func removeEventTimer(event: EventTimer) {
        eventTimers.removeAll { eventTimer in
            eventTimer.id == event.id
        }
        UserDefaultsConfigurator.shared.removeObject(forKey: Constants.userDefaultsKeyEventTimers)
        UserDefaultsConfigurator.shared.saveObjects(eventTimers, forKey: Constants.userDefaultsKeyEventTimers)
    }
}
