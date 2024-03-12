//
//  ConfigureTimerView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 14.11.2023.
//

import SwiftUI

struct ConfigureTimerView: View {
    
    private enum Constants {
        static let contentPadding: CGFloat = 16
        static let statusBarHeight: CGFloat = 44; #warning("поправить для высчитывания высоты статус бара")
        static let navigationContentPadding: CGFloat = 16
        static let spacingComponent: CGFloat = 8
        static let horizontalPaddingSpacing: CGFloat = 16
        static let buttonHeight: CGFloat = 40
        static let contentSpacing: CGFloat = 16
        static let buttonsDateSpacing: CGFloat = 16
        static let minimumDistance: CGFloat = 5
        static let navigationContentSpacing: CGFloat = 16
        static let backIconSize = CGSize(width: 16, height: 16)
        static let backButtonPadding: CGFloat = 12
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
                    VStack(spacing: Constants.contentSpacing) {
                        titleView
                        descriptionView
                        dateView
                        HStack(spacing: Constants.buttonsDateSpacing) {
                            setTodayButton
                                .frame(maxWidth: .infinity)
                            chooseDateButton
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(Constants.contentPadding)
                }
            }
            .background(DSColor.darkPrimary)
            .toolbar(.hidden, for: .navigationBar)
            
            if !isGoToDateHidden {
                QuiclyJumpToDateView { model in
                    withAnimation {
                        goToDate(dateModel: model)
                        isGoToDateHidden.toggle()
                    }
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                )
                .zIndex(1)
                .transition(.move(edge: isGoToDateHidden ? .top : .bottom))
                .gesture(DragGesture(minimumDistance: Constants.minimumDistance, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.height > 0 {
                            withAnimation {
                                isGoToDateHidden.toggle()
                            }
                        }
                    }))
            }
        }
        .ignoresSafeArea()
    }
    
    private var navigationBarView: some View {
        VStack {
            HStack {
            }
            .frame(height: Constants.statusBarHeight)
            VStack {
                HStack(spacing: Constants.navigationContentSpacing) {
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
                .frame(Constants.backIconSize)
                .padding(Constants.backButtonPadding)
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
            withAnimation {
                isGoToDateHidden.toggle()
            }
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
    
    private func goToDate(dateModel: GoToDateModel) {
        let dateDays = Calendar.current.date(byAdding: .day, value: dateModel.days, to: Date())
        let dateWeeks = Calendar.current.date(byAdding: .weekOfMonth, value: dateModel.weeks, to: dateDays ?? Date())
        let dateMonths = Calendar.current.date(byAdding: .month, value: dateModel.months, to: dateWeeks ?? Date())
        selectedDate = dateMonths ?? Date()
    }
}

#Preview {
    ConfigureTimerView(type: .create)
}
