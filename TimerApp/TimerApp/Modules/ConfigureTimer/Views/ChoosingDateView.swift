//
//  ChoosingDateView.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 12.03.24.
//

import SwiftUI

struct ChoosingDateView: View {
    
    private enum Constants {
        static let paddingDatePicker: CGFloat = 8
        static let spacingContent: CGFloat = 16
    }
    
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            datePickerView
        }
    }
    
    private var datePickerView: some View {
        DatePicker("", selection: $selectedDate)
            .datePickerStyle(.graphical)
            .tint(Color.green)
            .colorInvert()
            .colorMultiply(DSColor.violetSecondary)
            .padding(.horizontal, Constants.paddingDatePicker)
            .padding(.vertical, Constants.paddingDatePicker)
            .background(
                RoundedRectangle(cornerRadius: DSLayout.largeCornerRadius)
                    .fill(DSColor.darkSecondary)
            )
    }
}

#Preview {
    ConfigureTimerView(type: .create)
//    ChoosingDateView(selectedDate: .constant(Date()))
}
