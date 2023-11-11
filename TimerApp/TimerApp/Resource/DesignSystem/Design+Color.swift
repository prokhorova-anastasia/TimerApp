//
//  Design+Color.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 01.10.2023.
//

import Foundation
import SwiftUI

public struct DSColor {
    
    static let violetPrimary = Color("8972F7")
    static let violetSecondary = Color("B8AAFA")
    static let violetTertiary = Color("2C235A")
    static let violetTransparentPrimary = Color("2C235A").opacity(0.6)
    static let violetTransparentSecond = Color("8972F7").opacity(0.1)
    static let darkPrimary = Color("10091C")
    static let darkSecondary = Color("17102E")
    static let darkTertiary = Color("606686")
    static let darkTransparentPrimary = Color("17102E").opacity(0.6)
    static let darkTransparentSecond = Color("ADA5C8").opacity(0.3)
    static let errorPrimary = Color("FF616D")
    static let successPrimary = Color("5BE896")
    
    #warning("Old colors, remove after update to new desing")
    static let mainColor = Color("mainColor", bundle: nil)
    static let buttonColor = Color("buttonColor", bundle: nil)
    static let buttonTextColor = Color("buttonTextColor", bundle: nil)
    static let modalColor = Color("modalColor", bundle: nil)
    static let modalColorText = Color("modalColorText", bundle: nil)
    static let backgroundColor = Color("backgroundColor", bundle: nil)
    static let disableColor = Color("disableColor", bundle: nil)
    static let errorColor = Color("errorColor", bundle: nil)
    
    public enum ChoosingColors: CaseIterable, Hashable {
        static let bittersweet = Color("bittersweet", bundle: nil)
        static let blueMunsell = Color("blueMunsell", bundle: nil)
        static let celadon = Color("celadon", bundle: nil)
        static let cherryBlossomPink = Color("cherryBlossomPink", bundle: nil)
        static let chineRose = Color("chineRose", bundle: nil)
        static let naplesYellow = Color("naplesYellow", bundle: nil)
        static let poppy = Color("poppy", bundle: nil)
        static let powderBlue = Color("powderBlue", bundle: nil)
        static let verdigris = Color("verdigris", bundle: nil)
        static let violetBlue = Color("violetBlue", bundle: nil)
    }
    
    public enum TechColor {
        static let lightMainColor = Color("D9D9D9")
        static let darkMainColor = Color("222222")
        static let lightTextColorTimer = Color("F2F2F2")
    }
}
