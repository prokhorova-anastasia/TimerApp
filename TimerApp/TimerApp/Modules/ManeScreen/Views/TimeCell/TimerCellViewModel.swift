//
//  TimerCellViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.11.2023.
//

import Foundation
import SwiftUI
import Combine

final class TimerCellViewModel: ObservableObject {
    
    @Published var months: Int = 0
    @Published var weeks: Int = 0
    @Published var days: Int = 0
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    @ObservedObject private var generalTimer = GeneralTimer()
    private var eventTimer: EventTimer
    private var cancellable: Cancellable?
    private var anyCancellable: AnyCancellable?
    
    init(eventTimer: EventTimer) {
        self.eventTimer = eventTimer
        
        generalTimer.startTimer()
        setupTimer()
    }
    
    deinit {
        generalTimer.endTimer()
    }
    
    func setupTimer() {
        cancellable = generalTimer.timer.connect()
        anyCancellable = generalTimer.timer.sink(receiveValue: { [weak self] timer in
            guard let self = self else { fatalError("TimerCellViewModel.Self == nil")}
            self.months = self.eventTimer.getLeftMonths()
            self.weeks = self.eventTimer.getLeftWeeks()
            self.days = self.eventTimer.getLeftDays()
            self.hours = self.eventTimer.getLeftHours()
            self.minutes = self.eventTimer.getLeftMinutes()
            self.seconds = self.eventTimer.getLeftSeconds()
        })
//        _ = generalTimer.timer.sink { [weak self] _ in
//            guard let self = self else { fatalError("TimerCellViewModel.Self == nil")}
//            self.months = self.eventTimer.getLeftMonths()
//            self.weeks = self.eventTimer.getLeftWeeks()
//            self.days = self.eventTimer.getLeftDays()
//            self.hours = self.eventTimer.getLeftHours()
//            self.minutes = self.eventTimer.getLeftMinutes()
//            self.seconds = self.eventTimer.getLeftSeconds()
//        }
    }
}
