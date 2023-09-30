//
//  Router.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import SwiftUI

public enum SettingsType {
    case create, updateType
}

final class Router: ObservableObject {
    static let shared = Router()
    
    public enum Destination: Hashable {
        var identifier: String {
            return UUID().uuidString
        }
        
        public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
        }
        
        public static func == (lhs: Router.Destination, rhs: Router.Destination) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        case settings(_ type: SettingsType = .create, eventTimer: EventTimer?)
    }
    
    @Published var path = NavigationPath()
    
    func navigate(to destionation: Destination) {
        path.append(destionation)
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    func navigateToBack() {
        path.removeLast()
    }
}
