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
                MainScreenView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .settings:
                            SettingsEventTimerView()
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
