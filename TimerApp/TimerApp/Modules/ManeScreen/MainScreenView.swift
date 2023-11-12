//
//  MainScreenView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 11.11.2023.
//

import SwiftUI

struct MainScreenView: View {
    
    private enum Constants {
        static let timerViewPadding: CGFloat = 16
        static let contentPadding: CGFloat = 0
        static let statusBarHeight: CGFloat = 44; #warning("поправить для высчитывания высоты статус бара")
        static let navigationContentPadding: CGFloat = 16
        static let timersListBottomPadding: CGFloat = 16
        static let sortImageWidth: CGFloat = 16
        static let sortImagePadding: CGFloat = 12
        static let sortButtonCornerRadius: CGFloat = 25
    }
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = MainScreenViewModel()
    @ObservedObject var generalTimer = GeneralTimer()
    
    var body: some View {
        VStack {
            navigationBar
            timersListView
                .padding(Constants.timerViewPadding)
        }
        .padding(Constants.contentPadding)
        .ignoresSafeArea()
        .background(DSColor.darkPrimary)
        .onAppear {
            viewModel.getEventTimers()
        }
    }
    
    var navigationBar: some View {
        VStack {
            HStack {
            }
            .frame(height: Constants.statusBarHeight)
            HStack {
                Text("timers")
                    .font(DSFont.headline1)
                    .foregroundStyle(DSColor.white)
                Spacer()
                sortButtonView
            }
            .padding(Constants.navigationContentPadding)
        }
    }
    
    var sortButtonView: some View {
        Button {
            viewModel.sortTimers()
        } label: {
            ZStack {
                Image("sort_icon")
                    .frame(width: Constants.sortImageWidth, height: Constants.sortImageWidth)
                    .tint(DSColor.white)
                    .padding(Constants.sortImagePadding)
            }
            .background(
                RoundedRectangle(cornerRadius: Constants.sortButtonCornerRadius)
                .fill(DSColor.darkTransparentPrimary)
            )
        }
    }
    
    var timersListView: some View {
        ScrollView {
            ForEach($viewModel.eventTimers, id: \.id) { event in
                TimerCellView(eventTimer: event, shareAction: {
                    print("share")
                }, editAction: {
                    router.navigate(to: .settings(.updateType, eventTimer: event.wrappedValue))
                }, deleteAction: {
                    print("delete")
                })
                    .padding(.bottom, Constants.timersListBottomPadding)
            }
        }
    }
}

#Preview {
    MainScreenView()
}
