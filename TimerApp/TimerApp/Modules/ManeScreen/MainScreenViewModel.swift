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
        eventTimers = UserDefaultsConfigurator.shared.getObjects(EventTimer.self, forKey: UserDefaultsKeys.eventTimer.rawValue) ?? []
    }
    
    func removeAllEventTimers() {
        UserDefaultsConfigurator.shared.removeObject(forKey: UserDefaultsKeys.eventTimer.rawValue)
        eventTimers = []
    }
}
