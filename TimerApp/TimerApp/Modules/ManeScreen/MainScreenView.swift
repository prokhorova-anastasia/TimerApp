//
//  MainScreenView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import SwiftUI

struct MainScreenView: View {
    
    private enum Constants {
        static let baseColor = Color.black
        static let contentPadding: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        static let trashButtonTrailingButton: CGFloat = 8
        static let buttonWidth: CGFloat = 44
        static let cellBottomPaddong: CGFloat = 0
        static let listPadding: EdgeInsets = EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        static let heightWarningView: CGFloat = 300
        static let lowOpacity: CGFloat = 0.1
        static let oneSidePadding: CGFloat = 16
        static let createButtonPadding: EdgeInsets = EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
    }
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel = MainScreenViewModel()
    @ObservedObject var generalTimer = GeneralTimer()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(DSColor.mainColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(DSColor.mainColor)]
   }
    
    var body: some View {
        VStack {
            if viewModel.eventTimers.isEmpty {
                Spacer()
                WarningView()
                    .frame(maxWidth: .infinity, minHeight: Constants.heightWarningView, maxHeight: Constants.heightWarningView)
                    .background(
                        RoundedRectangle(cornerRadius: DSLayout.largeCornerRadius)
                            .fill(Color.black.opacity(Constants.lowOpacity))
                    )
                    .padding(.leading, Constants.oneSidePadding)
                    .padding(.trailing, Constants.oneSidePadding)
            } else {
                ScrollView {
                    eventTimersListView
                }
                .padding(Constants.contentPadding)
                .scrollIndicators(.hidden)
            }
            Spacer()
            createNewTimerEventButton
                .padding(Constants.createButtonPadding)
        }
        .navigationTitle(Text("timers"))
        .foregroundStyle(DSColor.mainColor)
        .toolbar(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.removeAllEventTimers()
                    generalTimer.endTimer()
                }, label: {
                    Image(systemName: "trash")
                        .foregroundStyle(DSColor.mainColor)

                })
                .padding(.trailing, Constants.trashButtonTrailingButton)
            }
        })
        .onAppear {
            viewModel.getEventTimers()
        }
    }
    
    private var createNewTimerEventButton: some View {
        Button(action: {
            router.navigate(to: .settings(.create, eventTimer: nil))
        }, label: {
            Text("addTimer")
                .font(DSFont.bodySemibold1)
                .foregroundStyle(DSColor.buttonTextColor)
                .frame(maxWidth: .infinity, minHeight: Constants.buttonWidth)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                        .fill(DSColor.buttonColor)
                )
        })
    }
    
    private var eventTimersListView: some View {
        VStack {
            ForEach($viewModel.eventTimers, id: \.id) { event in
                EventTimerCellView(eventTimer: event)
                    .background(
                        RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                            .stroke(DSColor.mainColor, lineWidth: 1)
                    )
                    .padding(.bottom, Constants.cellBottomPaddong)
                    .onTapGesture {
                        router.navigate(to: .settings(.updateType, eventTimer: event.wrappedValue))
                    }
                    .contextMenu(menuItems: {
                        Button(action: {
                            router.navigate(to: .settings(.updateType, eventTimer: event.wrappedValue))
                        }, label: {
                            HStack {
                                Image(systemName: "pencil")
                                Text("edit")
                                    .font(DSFont.body2)
                            }
                        })
                        Button(role: .destructive) {
                            viewModel.removeEventTimer(event: event.wrappedValue)
                        } label: {
                            HStack {
                                Image(systemName: "trash")
                                Text("delete")
                                    .font(DSFont.body2)
                            }
                        }
                    })
            }
        }
        .padding(Constants.listPadding)
    }
}

#Preview {
    MainScreenView()
}
