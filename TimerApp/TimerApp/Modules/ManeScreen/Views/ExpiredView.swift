//
//  ExpiredView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 01.10.2023.
//

import SwiftUI

struct ExpiredView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("timer_expired")
                .font(DSFont.body1)
                .foregroundStyle(DSColor.mainColor)
            Spacer()
        }
    }
}

#Preview {
    ExpiredView()
}
