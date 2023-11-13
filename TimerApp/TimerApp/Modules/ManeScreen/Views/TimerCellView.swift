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
        static let contentSpacing: CGFloat = 0
        static let minimumDistance: CGFloat = 3.0
    }
    
    @State var viewModel = MainScreenViewModel()
    @Binding var eventTimer: EventTimer
    @ObservedObject var generalTimer = GeneralTimer()
    @State var days = 0
    @State var hours = 0
    @State var minutes = 0
    @State var seconds = 0
    @State var isContextMenuHidden = true
    
    var shareAction: (() -> ())
    var editAction: (() -> ())
    var deleteAction: (() -> ())
    
    var body: some View {
        HStack(spacing: Constants.contentSpacing) {
            VStack(alignment: isContextMenuHidden ? .center : .leading , spacing: Constants.mainSpacing) {
                titleAndDescriptionView
                timerView
                targetDateView
            }
            .padding(Constants.mainPadding)
            .background(
                Color(eventTimer.colorBackground ?? "D9D9D9")
            )
            
            if !isContextMenuHidden {
                ContextMenuView {
                    shareAction()
                } editAction: {
                    editAction()
                } deleteAction: {
                    deleteAction()
                }
                .transition(.move(edge: isContextMenuHidden ? .leading : .trailing))
            }
                
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.timerContentCornerRadius))
        .onAppear {
            
            if UserDefaultsManager.shared.getBoolData(forKey: .wasFirstTimerCreated) {
                withAnimation(.linear(duration: 0.5)) {
                    isContextMenuHidden = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.linear(duration: 0.5)) {
                        isContextMenuHidden = true
                    }
                }
            }
            
            days = eventTimer.getLeftDays()
            hours = eventTimer.getLeftHours()
            minutes = eventTimer.getLeftMinutes()
            seconds = eventTimer.getLeftSeconds()
        }
        .gesture(DragGesture(minimumDistance: Constants.minimumDistance, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width < 0 {
                    withAnimation(.linear) {
                        isContextMenuHidden = false
                    }
                }
                if value.translation.width > 0 {
                    withAnimation(.linear) {
                        isContextMenuHidden = true
                    }
                }
            }
        )
    }
    
    var titleAndDescriptionView: some View {
        VStack {
            HStack(alignment: .center) {
                if isContextMenuHidden {
                    Spacer()
                }
                Text(eventTimer.title)
                    .font(DSFont.headline2)
                    .foregroundStyle(DSColor.darkPrimary)
                Spacer()
            }
            
            if let description = eventTimer.description {
                HStack {
                    if isContextMenuHidden {
                        Spacer()
                    }
                    Text(description)
                        .font(DSFont.body2)
                        .foregroundStyle(DSColor.darkPrimary)
                    Spacer()
                }
            }
        }
    }
    
    var timerView: some View {
        VStack(spacing: Constants.timerViewSpacing) {
            HStack {
                if isContextMenuHidden {
                    Spacer()
                }
                Text("left")
                    .font(DSFont.body3)
                    .foregroundStyle(DSColor.darkPrimary)
                Spacer()
            }
            HStack {
                if isContextMenuHidden {
                    Spacer()
                }
                HStack(spacing: Constants.timerContentSpacing) {
                    if days > 0 {
                        VStack {
                            Text("\(days)")
                                .font(DSFont.headline2)
                                .foregroundStyle(DSColor.darkPrimary)
                            Text("days")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.darkPrimary)
                        }
                    }
                    
                    if hours > 0 || days > 0 {
                        VStack {
                            Text("\(hours)")
                                .font(DSFont.headline2)
                                .foregroundStyle(DSColor.darkPrimary)
                            Text("hours")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.darkPrimary)
                        }
                    }
                    
                    if minutes > 0 || hours > 0{
                        VStack {
                            Text("\(minutes)")
                                .font(DSFont.headline2)
                                .foregroundStyle(DSColor.darkPrimary)
                            Text("minutes")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.darkPrimary)
                        }
                    }
                    
                    if seconds > 0 || minutes > 0 {
                        VStack {
                            Text("\(seconds)")
                                    .font(DSFont.headline2)
                                    .foregroundStyle(DSColor.darkPrimary)
                            Text("seconds")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.darkPrimary)
                        }
                    }
                }
                .padding(.horizontal, Constants.timerContentHorizontalPadding)
                .padding(.vertical, Constants.timerContentVetricalPadding)
                .background(
                    RoundedRectangle(cornerRadius: Constants.timerContentCornerRadius)
                        .fill(DSColor.darkTransparentPrimary)
                )
                Spacer()
            }
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
