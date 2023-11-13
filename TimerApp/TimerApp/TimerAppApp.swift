//
//  TimerAppApp.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 27.09.2023.
//

import SwiftUI

@main
struct TimerAppApp: App {
    
    @ObservedObject var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainTabbedView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .settings(let type, let eventTimer):
                            SettingsEventTimerView(type: type, eventTimer: eventTimer)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
