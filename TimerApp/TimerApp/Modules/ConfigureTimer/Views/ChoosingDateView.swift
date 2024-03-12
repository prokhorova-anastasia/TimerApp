//
//  ChoosingDateView.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 12.03.24.
//

import SwiftUI

struct ChoosingDateView: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(spacing: 16) {
            datePickerView
            HStack {
                setTodayButton
                Spacer()
                chooseDate
            }
        }
    }
    
    private var datePickerView: some View {
        DatePicker("", selection: $selectedDate)
            .datePickerStyle(.graphical)
            .tint(Color.green)
            .colorInvert()
            .colorMultiply(DSColor.violetSecondary)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                    .fill(DSColor.darkSecondary)
            )
    }
    
    private var setTodayButton: some View {
        Button(action: {
            selectedDate = Date()
        }, label: {
            Text("set_today")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.darkTertiary)
                .padding(.horizontal, 16)
                .frame(height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(DSColor.darkTertiary, lineWidth: DSLayout.borderWidth)
                )
        })
    }
    
    private var chooseDate: some View {
        Button(action: {
            selectedDate = Date()
        }, label: {
            Text("go_to_date")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.darkTertiary)
                .padding(.horizontal, 16)
                .frame(height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(DSColor.darkTertiary, lineWidth: DSLayout.borderWidth)
                )
        })
    }
}

#Preview {
    ConfigureTimerView(type: .create)
//    ChoosingDateView(selectedDate: .constant(Date()))
}
