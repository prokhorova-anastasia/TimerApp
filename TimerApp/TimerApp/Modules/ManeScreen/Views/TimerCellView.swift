//
//  TimerCellView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.11.2023.
//

import SwiftUI
import PhotosUI

struct TimerCellView: View {
    
    private enum Constants {
        static let mainSpacing: CGFloat = 16
        static let mainPadding: CGFloat = 16
        static let timerViewSpacing: CGFloat = 8
        static let timerContentSpacing: CGFloat = 12
        static let timerContentCornerRadius: CGFloat = 24
        static let timerContentHorizontalPadding: CGFloat = 16
        static let timerContentVetricalPadding: CGFloat = 4
        static let contentSpacing: CGFloat = 0
        static let minimumDistance: CGFloat = 3.0
    }
    
    @State var viewModel = MainScreenViewModel()
    @State var photosManager = PhotoManagerLegacy()
    @Binding var timerData: TimerData
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
        ZStack {
            if let photoName = timerData.photoName {
                AsyncImageView(photoName: photoName)
            }
            HStack(spacing: Constants.contentSpacing) {
                VStack(alignment: isContextMenuHidden ? .center : .leading , spacing: Constants.mainSpacing) {
                    titleAndDescriptionView
                    timerView
                    targetDateView
                }
                .padding(Constants.mainPadding)
                
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
                
                days = timerData.getLeftDays()
                hours = timerData.getLeftHours()
                minutes = timerData.getLeftMinutes()
                seconds = timerData.getLeftSeconds()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.timerContentCornerRadius))
        .gesture(DragGesture(minimumDistance: Constants.minimumDistance, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width < -30 {
                    withAnimation(.linear) {
                        isContextMenuHidden = false
                    }
                }
                if value.translation.width > 30 {
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
                Text(timerData.title)
                    .font(DSFont.headline2)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            
            if let description = timerData.description {
                HStack {
                    if isContextMenuHidden {
                        Spacer()
                    }
                    Text(description)
                        .font(DSFont.body2)
                        .foregroundStyle(DSColor.white)
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
                    .foregroundStyle(DSColor.white)
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
                                .foregroundStyle(DSColor.white)
                            Text("days")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.white)
                        }
                    }
                    
                    if hours > 0 || days > 0 {
                        VStack {
                            Text("\(hours)")
                                .font(DSFont.headline2)
                                .foregroundStyle(DSColor.white)
                            Text("hours")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.white)
                        }
                    }
                    
                    if minutes > 0 || hours > 0 {
                        VStack {
                            Text("\(minutes)")
                                .font(DSFont.headline2)
                                .foregroundStyle(DSColor.white)
                            Text("minutes")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.white)
                        }
                    }
                    
                    if seconds > 0 || minutes > 0 {
                        VStack {
                            Text("\(seconds)")
                                    .font(DSFont.headline2)
                                    .foregroundStyle(DSColor.white)
                            Text("seconds")
                                .font(DSFont.body2)
                                .foregroundStyle(DSColor.white)
                        }
                    }
                }
                .padding(.horizontal, Constants.timerContentHorizontalPadding)
                .padding(.vertical, Constants.timerContentVetricalPadding)
                .background(
                    RoundedRectangle(cornerRadius: Constants.timerContentCornerRadius)
                        .fill(DSColor.darkSecondary.opacity(0.8))
                )
                Spacer()
            }
        }
        .onReceive(generalTimer.timer, perform: { _ in
            #warning("изменить, чтобы таймер работал во вьюмоделе")
            days = timerData.getLeftDays()
            hours = timerData.getLeftHours()
            minutes = timerData.getLeftMinutes()
            seconds = timerData.getLeftSeconds()
        })
    }
    
    var targetDateView: some View {
        HStack(alignment: .center) {
            Text("\(timerData.targetDateToString())")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.white)
        }
    }
}

#Preview {
    MainScreenView()
//    TimerCellView(timerData:.constant(TimerData(title: "Title", description: "Description", targetDate: Date().addingTimeInterval(3600), colorBackground: "11FF22")))
}

