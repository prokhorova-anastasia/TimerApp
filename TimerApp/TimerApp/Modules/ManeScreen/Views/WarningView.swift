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
            if UserDefaultsManager.shared.getBoolData(forKey: .wasTimerCreated) {
                Text("timersExpiredModalMessage")
                    .padding(Constants.textPadding)
                    .multilineTextAlignment(.center)
                    .font(DSFont.bodySemibold1)
                    .foregroundStyle(DSColor.modalColorText)
            } else {
                Text("firstOpeningModalMessage")
                    .padding(Constants.textPadding)
                    .multilineTextAlignment(.center)
                    .font(DSFont.bodySemibold1)
                    .foregroundColor(DSColor.modalColorText)
            }
        }
    }
}

#Preview {
    WarningView()
}
