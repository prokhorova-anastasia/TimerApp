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
        static let cornerRaduis: CGFloat = 8
        static let contentPadding: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        static let trashButtonTrailingButton: CGFloat = 8
        static let buttonWidth: CGFloat = 44
        static let cellBottomPaddong: CGFloat = 0
        static let listPadding: EdgeInsets = EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
    }
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel = MainScreenViewModel()
    @ObservedObject var generalTimer = GeneralTimer()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
     UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
   }
    
    var body: some View {
        VStack {
            if viewModel.eventTimers.isEmpty {
                Spacer()
                WarningView()
                    .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black.opacity(0.1))
                            .shadow(color: .black, radius: 3)
                    )
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            } else {
                ScrollView {
                    eventTimersListView
                }
                .padding(Constants.contentPadding)
                .scrollIndicators(.hidden)
            }
            Spacer()
            createNewTimerEventButton
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
        }
        .navigationTitle(Text("Timers"))
        .toolbar(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.removeAllEventTimers()
                    generalTimer.endTimer()
                }, label: {
                    Image(systemName: "trash")
                        .foregroundStyle(Constants.baseColor)

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
            Text("Add timer")
                .font(Font.system(size: 17, weight: .semibold))
                .tint(Constants.baseColor)
                .frame(maxWidth: .infinity, minHeight: Constants.buttonWidth)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(color: .black, radius: 3)
                )
            
        })
    }
    
    private var eventTimersListView: some View {
        VStack {
            ForEach($viewModel.eventTimers, id: \.id) { event in
                EventTimerCellView(eventTimer: event)
                    .background(RoundedRectangle(cornerRadius: Constants.cornerRaduis)
                        .fill(Color.black.opacity(0.1))
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
                                Text("Edit")
                            }
                        })
                        Button(role: .destructive) {
                            viewModel.removeEventTimer(event: event.wrappedValue)
                        } label: {
                            HStack {
                                Image(systemName: "trash")
                                    .foregroundStyle(Color.red)
                                Text("Delete")
                                    .foregroundStyle(Color.red)
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
