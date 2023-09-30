//
//  EventTimerCellView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import SwiftUI

struct EventTimerCellView: View {
    
    private enum Constants {
        static let baseColor = Color.black
    }
    
    @State var viewModel = MainScreenViewModel()
    @Binding var eventTimer: EventTimer
    @ObservedObject var generalTimer = GeneralTimer()
    @State var days = 0
    @State var hours = 0
    @State var minutes = 0
    @State var seconds = 0
    
    var body: some View {
        VStack(spacing: 8) {
            Text(eventTimer.title)
                .foregroundStyle(Constants.baseColor)
                .font(Font.system(size: 17, weight: .bold))
            if let description = eventTimer.description {
                Text(description)
                    .foregroundStyle(Constants.baseColor).opacity(0.5)
                    .font(Font.system(size: 13))
            }
            timerView
        }
        .onAppear {
            days = eventTimer.getLeftDays()
            hours = eventTimer.getLeftHours()
            minutes = eventTimer.getLeftMinutes()
            seconds = eventTimer.getLeftSeconds()
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
    
    private var timerView: some View {
        HStack {
            VStack(spacing: 4) {
                Text("Days")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 15))
                Text("\(days)")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 17, weight: .semibold))
            }
            Spacer()
            VStack(spacing: 4) {
                Text("Hours")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 15))
                Text("\(hours)")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 17, weight: .semibold))
            }
            Spacer()

            VStack(spacing: 4) {
                Text("Minutes")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 15))
                Text("\(minutes)")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 17, weight: .semibold))
            }
            Spacer()

            VStack(spacing: 4) {
                Text("Seconds")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 15))
                Text("\(seconds)")
                    .foregroundStyle(Constants.baseColor)
                    .font(Font.system(size: 17, weight: .semibold))
            }
        }
        .onReceive(generalTimer.timer, perform: { _ in
            days = eventTimer.getLeftDays()
            hours = eventTimer.getLeftHours()
            minutes = eventTimer.getLeftMinutes()
            seconds = eventTimer.getLeftSeconds()
        })
    }
}

//#Preview {
//    EventTimerCellView(eventTimer: EventTimer(title: "IPhone", description: "Buy iphone", targetDate: Date().addingTimeInterval(360563)))
//}
