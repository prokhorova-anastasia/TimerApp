//
//  Design+Color.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 01.10.2023.
//

import Foundation
import SwiftUI

public struct DSColor {
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
}
