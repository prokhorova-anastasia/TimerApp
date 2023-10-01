//
//  WarningView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 30.09.2023.
//

import SwiftUI

struct WarningView: View {
    private enum Constants {
        static let textPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }
    var body: some View {
        VStack {
            if UserDefaultsConfigurator.shared.getBoolData(forKey: .wasTimerCreated) {
                Text("Hello! It seems all your timers have already expired. Would you like to create a new one?")
                    .padding(Constants.textPadding)
                    .multilineTextAlignment(.center)
                    .font(DSFont.bodySemibold1)
                    .foregroundStyle(DSColor.mainColor)
            } else {
                Text("Hello! Create your first timer by pressing 'Add timer'!")
                    .padding(Constants.textPadding)
                    .multilineTextAlignment(.center)
                    .font(DSFont.bodySemibold1)
                    .foregroundColor(DSColor.mainColor)
            }
        }
    }
}

#Preview {
    WarningView()
}
