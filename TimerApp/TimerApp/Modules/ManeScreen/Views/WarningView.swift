//
//  WarningView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 30.09.2023.
//

import SwiftUI

struct WarningView: View {
    var body: some View {
        VStack {
            if UserDefaultsConfigurator.shared.getBoolData(forKey: .wasTimerCreated) {
                Text("Hello! It seems all your timers have already expired. Would you like to create a new one?")
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 18, weight: .semibold))
            } else {
                Text("Hello! Create your first timer by pressing 'Add timer'!")
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 18, weight: .semibold))
            }
        }
    }
}

#Preview {
    WarningView()
}
