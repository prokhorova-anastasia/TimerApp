//
//  ConfigureTimerView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 14.11.2023.
//

import SwiftUI

struct ConfigureTimerView: View {
    
    private enum Constants {
        static let contentPadding: CGFloat = 0
        static let statusBarHeight: CGFloat = 44; #warning("поправить для высчитывания высоты статус бара")
        static let navigationContentPadding: CGFloat = 16
    }
    
    @EnvironmentObject var router: Router
    @State var eventTimer: EventTimer?
    @State var titleString: String = ""
    @State var descriptionString: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                navigationBarView
                Spacer()
            }
        }
        .padding(Constants.contentPadding)
        .ignoresSafeArea()
        .background(DSColor.darkPrimary)
    }
    
    private var navigationBarView: some View {
        VStack(spacing: 0) {
            HStack {
            }
            .frame(height: Constants.statusBarHeight)
            VStack(spacing: 24) {
                HStack(spacing: 16) {
                    backButtonView
                    Text("new_timer")
                        .font(DSFont.headline1)
                        .foregroundStyle(DSColor.white)
                    Spacer()
                }
            }
            .padding(Constants.navigationContentPadding)
        }
    }
    
    private var backButtonView: some View {
        Button {
            router.navigateToBack()
        } label: {
            Image("back_icon")
                .frame(width: 16, height: 16)
                .padding(12)
        }
        .background(
            Circle()
                .fill(DSColor.darkTransparentPrimary)
        )
    }
}

#Preview {
    ConfigureTimerView()
}
