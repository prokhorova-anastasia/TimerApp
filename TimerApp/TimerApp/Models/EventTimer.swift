//
//  EventTimer.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation

struct EventTimer: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String?
    var targetDate: Date?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, targetDate
    }
    
    init(title: String, description: String?, targetDate: Date?) {
        self.title = title
        self.description = description
        self.targetDate = targetDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: CodingKeys.id)
        self.title = try container.decode(String.self, forKey: CodingKeys.title)
        self.description = try container.decodeIfPresent(String.self, forKey: CodingKeys.description)
        self.targetDate = try container.decodeDate(forKey: CodingKeys.targetDate)
    }
}

extension EventTimer {
    func getLeftDays() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.day], from: Date(), to: targetDate ?? Date())
        return components.day ?? 0
    }
    
    func getLeftHours() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.hour], from: Date(), to: targetDate ?? Date())
        let allHours = components.hour ?? 0
        return allHours % 24
    }
    
    func getLeftMinutes() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.minute], from: Date(), to: targetDate ?? Date())
        let allHours = components.minute ?? 0
        return allHours % 60
    }
    
    func getLeftSeconds() -> Int {
        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.second], from: Date(), to: targetDate ?? Date())
        let allHours = components.second ?? 0
        return allHours % 60
    }
}
