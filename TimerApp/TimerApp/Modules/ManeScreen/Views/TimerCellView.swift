//
//  TimerCellView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.11.2023.
//

import SwiftUI

struct TimerCellView: View {
    
    private enum Constants {
        static let mainSpacing: CGFloat = 16
        static let mainPadding: CGFloat = 16
        static let timerViewSpacing: CGFloat = 8
        static let timerContentSpacing: CGFloat = 12
        static let timerContentCornerRadius: CGFloat = 24
        static let timerContentHorizontalPadding: CGFloat = 12
        static let timerContentVetricalPadding: CGFloat = 4
    }
    
    @State var viewModel = MainScreenViewModel()
    @Binding var eventTimer: EventTimer
    @ObservedObject var generalTimer = GeneralTimer()
    @State var days = 0
    @State var hours = 0
    @State var minutes = 0
    @State var seconds = 0
    
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            titleAndDescriptionView
            timerView
            targetDateView
        }
        .padding(Constants.mainPadding)
        .background(
            RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                .fill(Color(eventTimer.colorBackground ?? "D9D9D9"))
            )
        .onAppear {
            days = eventTimer.getLeftDays()
            hours = eventTimer.getLeftHours()
            minutes = eventTimer.getLeftMinutes()
            seconds = eventTimer.getLeftSeconds()
        }
    }
    
    var titleAndDescriptionView: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text(eventTimer.title)
                    .font(DSFont.headline2)
                    .foregroundStyle(DSColor.darkPrimary)
                Spacer()
            }
            
            if let description = eventTimer.description {
                HStack(alignment: .center) {
                    Text(description)
                        .font(DSFont.body2)
                        .foregroundStyle(DSColor.darkPrimary)
                }
            }
        }
    }
    
    var timerView: some View {
        VStack(spacing: Constants.timerViewSpacing) {
            HStack {
                Text("left")
                    .font(DSFont.body3)
                    .foregroundStyle(DSColor.darkPrimary)
            }
            
            HStack(spacing: Constants.timerContentSpacing) {
                VStack {
                    Text("\(days)")
                        .font(DSFont.headline2)
                        .foregroundStyle(DSColor.darkPrimary)
                    Text("days")
                        .font(DSFont.body2)
                        .foregroundStyle(DSColor.darkPrimary)
                }
                
                VStack {
                    Text("\(hours)")
                        .font(DSFont.headline2)
                        .foregroundStyle(DSColor.darkPrimary)
                    Text("hours")
                        .font(DSFont.body2)
                        .foregroundStyle(DSColor.darkPrimary)
                }
                
                VStack {
                    Text("\(minutes)")
                        .font(DSFont.headline2)
                        .foregroundStyle(DSColor.darkPrimary)
                    Text("minutes")
                        .font(DSFont.body2)
                        .foregroundStyle(DSColor.darkPrimary)
                }
                
                VStack {
                    Text("\(seconds)")
                        .font(DSFont.headline2)
                        .foregroundStyle(DSColor.darkPrimary)
                    Text("seconds")
                        .font(DSFont.body2)
                        .foregroundStyle(DSColor.darkPrimary)
                }
            }
            .padding(.horizontal, Constants.timerContentHorizontalPadding)
            .padding(.vertical, Constants.timerContentVetricalPadding)
            .background(
                RoundedRectangle(cornerRadius: Constants.timerContentCornerRadius)
                .fill(DSColor.darkTransparentPrimary)
            )
        }
        .onReceive(generalTimer.timer, perform: { _ in
            #warning("изменить, чтобы таймер работал во вьюмоделе")
            days = eventTimer.getLeftDays()
            hours = eventTimer.getLeftHours()
            minutes = eventTimer.getLeftMinutes()
            seconds = eventTimer.getLeftSeconds()
        })
    }
    
    var targetDateView: some View {
        HStack(alignment: .center) {
            Text("\(eventTimer.targetDateToString())")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.darkPrimary)
        }
    }
}

#Preview {
    MainScreenView()
//    TimerCellView(eventTimer:.constant(EventTimer(title: "Title", description: "Description", targetDate: Date().addingTimeInterval(3600), colorBackground: "11FF22")))
}
