//
//  GeneralTimer.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 29.09.2023.
//

import Foundation

final class GeneralTimer: ObservableObject {
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        print("timer start")
    }
    
    func endTimer() {
        timer.upstream.connect().cancel()
        print("timer stopped")
    }
    
}
