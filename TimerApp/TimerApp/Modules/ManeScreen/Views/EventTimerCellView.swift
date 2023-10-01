//
//  EventTimerCellView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import SwiftUI

struct EventTimerCellView: View {
    
    private enum Constants {
        static let timesSpacing: CGFloat = 4
        static let contentSpacing: CGFloat = 8
        static let middleOpacity: CGFloat = 0.5
        static let contentPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }
    
    @State var viewModel = MainScreenViewModel()
    @Binding var eventTimer: EventTimer
    @ObservedObject var generalTimer = GeneralTimer()
    @State var days = 0
    @State var hours = 0
    @State var minutes = 0
    @State var seconds = 0
    
    var body: some View {
        VStack(spacing: Constants.contentSpacing) {
            Text(eventTimer.title)
                .foregroundStyle(DSColor.mainColor)
                .font(DSFont.bodySemibold1)
            if let description = eventTimer.description {
                Text(description)
                    .foregroundStyle(DSColor.mainColor).opacity(Constants.middleOpacity)
                    .font(DSFont.body3)
            }
            timerView
        }
        .onAppear {
            days = eventTimer.getLeftDays()
            hours = eventTimer.getLeftHours()
            minutes = eventTimer.getLeftMinutes()
            seconds = eventTimer.getLeftSeconds()
        }
        .padding(Constants.contentPadding)
    }
    
    private var timerView: some View {
        HStack {
            VStack(spacing: Constants.timesSpacing) {
                Text("days")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Text("\(days)")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.bodySemibold1)
            }
            Spacer()
            VStack(spacing: Constants.timesSpacing) {
                Text("hours")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Text("\(hours)")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.bodySemibold1)
            }
            Spacer()

            VStack(spacing: Constants.timesSpacing) {
                Text("minutes")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Text("\(minutes)")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.bodySemibold1)
            }
            Spacer()

            VStack(spacing: Constants.timesSpacing) {
                Text("seconds")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Text("\(seconds)")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.bodySemibold1)
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
