//
//  Design+Font.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 30.09.2023.
//

import Foundation
import SwiftUI

public struct DSFont {
    static let largeTitle = Font.system(size: 34, weight: .semibold, design: .rounded)
    static let title = Font.system(size: 21, weight: .semibold, design: .rounded)
    static let body1 = Font.system(size: 17, design: .rounded)
    static let body2 = Font.system(size: 15, design: .rounded)
    static let body3 = Font.system(size: 13, design: .rounded)
    static let bodySemibold1 = Font.system(size: 17, weight: .semibold, design: .rounded)
    static let bodySemibold2 = Font.system(size: 15, weight: .semibold, design: .rounded)
    static let bodySemibold3 = Font.system(size: 13, weight: .semibold, design: .rounded)
    static let bodySemibold4 = Font.system(size: 11, weight: .semibold, design: .rounded)
    static let caption = Font.system(size: 12, design: .rounded)
    static let caption2 = Font.system(size: 11, design: .rounded)
    static let caption3 = Font.system(size: 10, design: .rounded)
}
