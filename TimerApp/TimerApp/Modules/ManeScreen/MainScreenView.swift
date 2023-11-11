//
//  MainScreenView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 11.11.2023.
//

import SwiftUI

struct MainScreenView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = MainScreenViewModel()
    @ObservedObject var generalTimer = GeneralTimer()
    
    var body: some View {
        VStack {
            navigationBar
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
            .frame(height: 44)
            HStack {
                Text("timers")
                    .font(DSFont.headline1)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    MainScreenView()
}
