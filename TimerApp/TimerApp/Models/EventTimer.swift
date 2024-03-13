//
//  EventTimer.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import SwiftUI

struct EventTimer: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String?
    var targetDate: Date
    var colorBackground: String?
    var photoName: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, targetDate, colorBackground, photoName
    }
    
    init(title: String, description: String?, targetDate: Date, colorBackground: String?, photoName: String?) {
        self.title = title
        self.description = description
        self.targetDate = targetDate
        self.colorBackground = colorBackground
        self.photoName = photoName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.targetDate = try container.decodeDate(forKey: .targetDate) ?? Date()
        self.colorBackground = try container.decodeIfPresent(String.self, forKey: .colorBackground)
        self.photoName = try container.decodeIfPresent(String.self, forKey: .photoName)
    }
}

extension EventTimer {
    
    func getLeftMonths() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.month], from: Date(), to: targetDate)
        let months = components.month ?? 0
        return months
    }
    
    func getLeftWeeks() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.day], from: Date(), to: targetDate)
        let allDays = components.day ?? 0
        return allDays / 7
    }
    
    func getLeftDays() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.day], from: Date(), to: targetDate)
        return components.day ?? 0
    }
    
    func getLeftHours() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.hour], from: Date(), to: targetDate)
        let allHours = components.hour ?? 0
        return allHours % 24
    }
    
    func getLeftMinutes() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.minute], from: Date(), to: targetDate)
        let allHours = components.minute ?? 0
        return allHours % 60
    }
    
    func getLeftSeconds() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.second], from: Date(), to: targetDate)
        let allHours = components.second ?? 0
        return allHours % 60
    }
    
    func timerWasExpired() -> Bool {
        return targetDate < Date()
    }
    
    func targetDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: targetDate)
    }
}
