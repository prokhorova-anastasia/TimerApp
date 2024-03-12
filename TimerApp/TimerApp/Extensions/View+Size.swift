//
//  View+Size.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 12.03.24.
//

import SwiftUI

extension View {
    func frame(_ size: CGSize) -> some View {
        return frame(width: size.width, height: size.height)
    }
}
