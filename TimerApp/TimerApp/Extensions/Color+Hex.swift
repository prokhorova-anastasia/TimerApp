//
//  Color+Hex.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 04.10.2023.
//

import Foundation

import SwiftUI

public extension Color {

    // MARK: - Public variables

    var hexString: String {
        let uiColor = UIColor(self)
        let components = uiColor.cgColor.components
        let red: CGFloat = components?[0] ?? 0.0
        let green: CGFloat = components?[1] ?? 0.0
        let blue: CGFloat = components?[2] ?? 0.0

        return String(format: "%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
    }

    // MARK: - Initialization
    
    init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
    }
    
    init(_ intHex: Int) {
        self.init(red: (intHex >> 16) & 0xFF, green: (intHex >> 8) & 0xFF, blue: intHex & 0xFF)
    }
    
    init(_ intHex: Int64) {
        self.init(Int(intHex))
    }
    
    init(_ stringHex: String) {
        let characterSet = Set("0123456789ABCDEF")
        let completedString = stringHex.uppercased().filter { characterSet.contains($0) }
        
        guard completedString.count <= 6 else {
            print("#ERR", Self.self, #function, "color hex string contains more than 6 chars")
            self.init(0)
            return
        }
        let intHex = Int(completedString, radix: 16)!
        self.init(intHex)
    }
}

