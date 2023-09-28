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
        static let buttonWidth: CGFloat = 64
        static let cellBottomPaddong: CGFloat = 8
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
        ZStack(alignment: .bottom) {
            ScrollView {
                eventTimersListView
            }
            .padding(Constants.contentPadding)
            .scrollIndicators(.hidden)
            createNewTimerEventButton
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
            Image(systemName: "plus")
                .tint(Constants.baseColor)
                .frame(width: Constants.buttonWidth, height: Constants.buttonWidth)
                .background(
                    RoundedRectangle(cornerRadius: Constants.buttonWidth / 2)
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
                        .fill(Color.white)
                        .shadow(color: Constants.baseColor.opacity(0.3), radius: 5, x: 0, y: 5))
                    .padding(.bottom, Constants.cellBottomPaddong)
                    .onTapGesture {
                        router.navigate(to: .settings(.updateType, eventTimer: event.wrappedValue))
                    }
            }
        }
        .padding(Constants.listPadding)
    }
}

#Preview {
    MainScreenView()
}
