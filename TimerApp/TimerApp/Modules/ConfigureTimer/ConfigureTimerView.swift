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
        static let spacingComponent: CGFloat = 8
        static let horizontalPaddingSpacing: CGFloat = 16
        static let buttonHeight: CGFloat = 40
    }
    
    @EnvironmentObject var router: Router
    @State var type: SettingsType
    @State var eventTimer: EventTimer?
    @State var titleString: String = ""
    @State var descriptionString: String = ""
    @State var selectedDate = Date()
    
    @State private var isGoToDateHidden = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                navigationBarView
                ScrollView {
                    VStack(spacing: 16) {
                        titleView
                        descriptionView
                        dateView
                        HStack(spacing: 16) {
                            setTodayButton
                                .frame(width: .infinity)
                            chooseDateButton
                                .frame(width: .infinity)
                        }
                    }
                    .padding(16)
                }
            }
            .padding(Constants.contentPadding)
            .background(DSColor.darkPrimary)
            .toolbar(.hidden, for: .navigationBar)
            
            if !isGoToDateHidden {
                QuiclyJumpToDateView { model in
                    isGoToDateHidden = true
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                )
                .animation(.linear, value: isGoToDateHidden)
            }
        }
        .ignoresSafeArea()
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
    
    private var titleView: some View {
        VStack(spacing: Constants.spacingComponent) {
            HStack {
                Text("title")
                    .font(DSFont.title1)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            TextFieldView(placeholder: String(localized: "title"), isError: .constant(false))
        }
    }
    
    private var descriptionView: some View {
        VStack(spacing: Constants.spacingComponent) {
            HStack {
                Text("description")
                    .font(DSFont.title1)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            TextFieldView(placeholder:
                            String(localized: "description"), isError: .constant(false), lineLimit: 3)
        }
    }
    
    private var dateView: some View {
        VStack(spacing: Constants.spacingComponent) {
            HStack {
                Text("date")
                    .font(DSFont.title1)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            ChoosingDateView(selectedDate: $selectedDate)
        }
    }
    
    private var setTodayButton: some View {
        Button(action: {
            selectedDate = Date()
        }, label: {
            Text("set_today")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.darkTertiary)
                .padding(.horizontal, Constants.horizontalPaddingSpacing)
                .frame(height: Constants.buttonHeight)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                        .stroke(DSColor.darkTertiary, lineWidth: DSLayout.borderWidth)
                )
        })
    }
    
    private var chooseDateButton: some View {
        Button(action: {
            isGoToDateHidden = false
        }, label: {
            Text("go_to_date")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.darkTertiary)
                .padding(.horizontal, Constants.horizontalPaddingSpacing)
                .frame(height: Constants.buttonHeight)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                        .stroke(DSColor.darkTertiary, lineWidth: DSLayout.borderWidth)
                )
        })
    }
}

#Preview {
    ConfigureTimerView(type: .create)
}
