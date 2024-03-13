//
//  MainScreenViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import SwiftUI
import PhotosUI

final class MainScreenViewModel: ObservableObject {
    
    @Published var eventTimers: [EventTimer] = []
    
    private var allTimers: [EventTimer] = []
    
    init() {
        getEventTimers()
    }
    
    func getEventTimers() {
//#if DEBUG
//        getTestTimers()
//#else
        allTimers = UserDefaultsManager.shared.getObjects(EventTimer.self, forKey: .eventTimer) ?? []
        eventTimers = allTimers
//#endif
    }
    
    func removeAllEventTimers() {
        UserDefaultsManager.shared.removeObject(forKey: .eventTimer)
        eventTimers = []
        allTimers = []
    }
    
    func removeEventTimer(event: EventTimer) {
        eventTimers.removeAll { eventTimer in
            eventTimer.id == event.id
        }
        
        allTimers.removeAll { eventTimer in
            eventTimer.id == event.id
        }
        UserDefaultsManager.shared.removeObject(forKey: .eventTimer)
        UserDefaultsManager.shared.saveObjects(eventTimers, forKey: .eventTimer)
    }
    
    func sortTimers() {
        eventTimers = allTimers.sorted { timer1, timer2 in
            timer2.targetDate > timer1.targetDate
        }
    }
    
    func filterTimersByText(_ text: String) {
        eventTimers = allTimers.filter({$0.title.contains(text)})
    }
    
    func getAllTimers() {
        eventTimers = allTimers
    }
    
    private func getTestTimers() {
        let events = [
            EventTimer(title: "Title1", description: "Description1", targetDate: Date().addingTimeInterval(3600), colorBackground: nil, photoName: nil),
            EventTimer(title: "Title2", description: "Description2", targetDate: Date().addingTimeInterval(1000), colorBackground: "123456", photoName: nil),
            EventTimer(title: "Title3", description: "Description3", targetDate: Date().addingTimeInterval(2000), colorBackground: "1234A6", photoName: nil),
            EventTimer(title: "Title4", description: "Description4", targetDate: Date().addingTimeInterval(4000), colorBackground: "12E456", photoName: nil)
        ]
        eventTimers = events
        allTimers = events
    }
}
