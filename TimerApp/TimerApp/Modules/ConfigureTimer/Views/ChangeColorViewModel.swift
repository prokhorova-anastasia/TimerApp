//
//  ChangeColorViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 03.10.2023.
//

import Foundation
import SwiftUI

struct ChangeColor: Hashable {
    let id = UUID().uuidString
    let color: Color
}

final class ChangeColorViewModel: ObservableObject {
    
    @Published var colors: [ChangeColor] = [ChangeColor(color: Color("8972F7")),
                                 ChangeColor(color: Color("F5FE8C")),
                                 ChangeColor(color: Color("71EE7E")),
                                 ChangeColor(color: Color("EE719E")),
                                 ChangeColor(color: Color("27DDE9"))]
}
