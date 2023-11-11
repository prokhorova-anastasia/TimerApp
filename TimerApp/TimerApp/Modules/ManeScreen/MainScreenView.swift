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
            viewModel.getTestTimers()
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
            }
            .padding(Constants.navigationContentPadding)
        }
    }
    
    var timersListView: some View {
        ScrollView {
            ForEach($viewModel.eventTimers, id: \.id) { event in
                TimerCellView(eventTimer: event)
                    .padding(.bottom, Constants.timersListBottomPadding)
            }
        }
    }
}

#Preview {
    MainScreenView()
}
