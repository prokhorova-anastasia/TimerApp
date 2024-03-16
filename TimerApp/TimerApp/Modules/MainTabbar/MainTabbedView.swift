//
//  MainTabbarView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 13.11.2023.
//

import SwiftUI

enum TabBarItems: Int, CaseIterable {
    case timers = 0
    case settings
    
    var title: String {
        switch self {
        case .timers:
            return String(localized: "timers_tabbar_item")
        case .settings:
            return String(localized: "settings_tabbar_item")
        }
    }
    
    var icon: String {
        switch self {
        case .timers:
            return "clock_icon"
        case .settings:
            return "settings_icon"
        }
    }
}

struct MainTabbedView: View {
    
    private enum Constants {
        static let tabBarHeight: CGFloat = 44
        static let itemContentSpacing: CGFloat = 8
        static let imageWidth: CGFloat = 20
        static let itemContentPadding: CGFloat = 16
        static let buttonWidth: CGFloat = 80
        static let backgroundButtonWidth: CGFloat = 78
        static let buttonPadding: CGFloat = -16
    }
    
    @EnvironmentObject var router: Router
    @State var selectedTab: Int = 0
    
    init() {
        let transparentAppearence = UITabBarAppearance()
        transparentAppearence.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = transparentAppearence
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                MainScreenView()
                    .tag(0)
            }
            
            
            ZStack {
                GeometryReader { geometry in
                    HStack {
                        ForEach(TabBarItems.allCases, id: \.self) { item in
                            Button {
                                selectedTab = item.rawValue
                            } label: {
                                Spacer()
                                VStack(spacing: Constants.itemContentSpacing) {
                                    Image(item.icon)
                                        .frame(width: Constants.imageWidth, height: Constants.imageWidth)
                                        .tint(selectedTab == item.rawValue ? DSColor.white : DSColor.darkTertiary)
                                    Text(item.title)
                                        .font(DSFont.caption)
                                        .foregroundStyle(selectedTab == item.rawValue ? DSColor.white : DSColor.darkTertiary)
                                }
                                .padding(Constants.itemContentPadding)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .frame(height: Constants.tabBarHeight)
            .background(DSColor.darkSecondary)
            
            ZStack {
                Button {
                    router.navigate(to: .settings(.create, timerData: nil))
                } label: {
                    Image("add_timer_icon")
                        .frame(width: Constants.buttonWidth, height: Constants.buttonWidth)
                }
                .background(
                    Circle()
                        .fill(DSColor.darkSecondary)
                        .frame(width: Constants.backgroundButtonWidth, height: Constants.backgroundButtonWidth)
                )
            }
            .padding(.bottom, Constants.buttonPadding)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainTabbedView()
}
