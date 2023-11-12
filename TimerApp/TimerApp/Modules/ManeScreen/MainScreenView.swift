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
        static let imageWidth: CGFloat = 16
        static let sortImagePadding: CGFloat = 12
        static let sortButtonCornerRadius: CGFloat = 25
        static let searchImagePadding: CGFloat = 16
        static let largeCornerRadius: CGFloat = 24
        static let borderWidth: CGFloat = 1
    }
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = MainScreenViewModel()
    @ObservedObject var generalTimer = GeneralTimer()
    
    @State var searchText: String = ""
    @FocusState private var isFocused: Bool
    
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
        VStack(spacing: 0) {
            HStack {
            }
            .frame(height: Constants.statusBarHeight)
            VStack(spacing: 24) {
                HStack {
                    Text("timers")
                        .font(DSFont.headline1)
                        .foregroundStyle(DSColor.white)
                    Spacer()
                    sortButtonView
                }
                searchView
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
                    .frame(width: Constants.imageWidth, height: Constants.imageWidth)
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
                TimerCellView(viewModel: TimerCellViewModel(eventTimer: event.wrappedValue), eventTimer: event, shareAction: {
                    print("share")
                }, editAction: {
                    router.navigate(to: .settings(.updateType, eventTimer: event.wrappedValue))
                }, deleteAction: {
                    viewModel.removeEventTimer(event: event.wrappedValue)
                })
                    .padding(.bottom, Constants.timersListBottomPadding)
            }
        }
    }
    
    var searchView: some View {
        HStack {
            Image("search_icon")
                .frame(width: Constants.imageWidth, height: Constants.imageWidth)
                .padding(Constants.searchImagePadding)
            
            TextField("", text: $searchText)
                .focused($isFocused)
                .onChange(of: searchText) { text in
                    if !text.isEmpty {
                        viewModel.filterTimersByText(text)
                    } else {
                        viewModel.getAllTimers()
                    }
                }
                .foregroundStyle(DSColor.white)
                .font(DSFont.body1)
                .tint(DSColor.white)
                .padding(.trailing, 16)
                .padding(.vertical, 12)
                
                
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.largeCornerRadius)
                .fill(DSColor.darkTransparentPrimary)
        )
        .background(
            RoundedRectangle(cornerRadius: Constants.largeCornerRadius)
                .stroke(isFocused ? DSColor.violetPrimary : Color.clear, lineWidth: Constants.borderWidth)
        )
    }
}

#Preview {
    MainScreenView()
}
