//
//  Router.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    static let shared = Router()
    
    public enum Destination: Hashable {
        case settings
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
