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
        #if DEBUG
        getTestTimers()
        #else
        eventTimers = UserDefaultsManager.shared.getObjects(EventTimer.self, forKey: .eventTimer) ?? []
        #endif
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
    
    func getTestTimers() {
        let events = [
            EventTimer(title: "Title1", description: "Description1", targetDate: Date().addingTimeInterval(3600), colorBackground: nil),
            EventTimer(title: "Title2", description: "Description2", targetDate: Date().addingTimeInterval(1000), colorBackground: "123456")
        ]
        eventTimers = events
    }
    
    func sortTimers() {
        eventTimers = eventTimers.sorted { timer1, timer2 in
            timer2.targetDate > timer1.targetDate
        }
    }
}
