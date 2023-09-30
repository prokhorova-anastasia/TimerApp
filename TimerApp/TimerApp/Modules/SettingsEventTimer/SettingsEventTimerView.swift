//
//  SettingsEventTimerView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import SwiftUI

struct SettingsEventTimerView: View {
    
    private enum Constants {
        static let contentPadding: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        static let contentSpacing: CGFloat = 24
        static let itemSpacing: CGFloat = 8
        static let cornerRaduis: CGFloat = 8
        static let itemPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        static let baseColor = Color.black
        static let buttonPadding: EdgeInsets = EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16)
    }
    
    @EnvironmentObject var router: Router
    
    @State var type: SettingsType
    @State var eventTimer: EventTimer?
    @State var titleString: String = ""
    @State var descriptionString: String = ""
    @State var choosedDate: Date = Date()
    @State var viewModel = SettingsEventTimerViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: Constants.contentSpacing) {
                    titleView
                    descriptionView
                    chooseDateView
                }
                .padding(Constants.itemPadding)
            }
            .scrollIndicators(.hidden)
            createButtonView
                .padding(Constants.buttonPadding)
        }
        .padding(Constants.contentPadding)
        .navigationTitle(Text(type == .create ? "Create" : "Update"))
        .toolbar(.visible, for: .navigationBar)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.navigateToBack()
                }, label: {
                    Text("Back")
                })
                .padding(.leading, 8)
            }
        })
        .navigationBarBackButtonHidden()
        .foregroundColor(Constants.baseColor)
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear{
            if type == .updateType {
                titleString = eventTimer?.title ?? ""
                descriptionString = eventTimer?.description ?? ""
                choosedDate = eventTimer?.targetDate ?? Date()
            }
        }
    }
    
    private var titleView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Title")
                    .foregroundStyle(Constants.baseColor)
                Spacer()
            }
            TextField("", text: $titleString, prompt: Text("Type title...").foregroundColor(Constants.baseColor.opacity(0.4)))
                .foregroundStyle(Constants.baseColor.opacity(0.8))
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRaduis)
            .fill(Color.white)
            .shadow(color: Constants.baseColor.opacity(0.3), radius: 5, x: 0, y: 5))
    }
    
    private var descriptionView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Description")
                    .foregroundStyle(Constants.baseColor)
                Spacer()
            }
            TextField("", text: $descriptionString, prompt: Text("Type description...").foregroundColor(Constants.baseColor.opacity(0.4)))
                .foregroundStyle(Constants.baseColor.opacity(0.8))
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRaduis)
            .fill(Color.white)
            .shadow(color: Constants.baseColor.opacity(0.3), radius: 5, x: 0, y: 5))
    }
    
    private var chooseDateView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Choose date")
                    .foregroundStyle(Constants.baseColor)
                Spacer()
            }
            DatePicker("Choose date", selection: $choosedDate)
                .tint(.black)
                .foregroundStyle(Constants.baseColor)
                .datePickerStyle(.graphical)
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRaduis)
            .fill(Color.white)
            .shadow(color: Constants.baseColor.opacity(0.3), radius: 5, x: 0, y: 5))
    }
    
    private var createButtonView: some View {
        HStack {
            Button(action: {
                switch type {
                case .create:
                    viewModel.saveEventTimer(title: titleString, description: descriptionString, targetDate: choosedDate)
                case .updateType:
                    #warning("Поменять обработку нила для eventTimer. Например: если еventTimer = nil и type == .update, то показывать ошибку")
                    guard let event = eventTimer else { return}
                    var newEvent  = event
                    newEvent.title = titleString
                    newEvent.description = descriptionString
                    newEvent.targetDate = choosedDate
                    viewModel.updateEventTimer(eventTimer: newEvent)
                }
                
                router.navigateToBack()
            }, label: {
                Text(type == .create ? "Create" : "Update")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(
                        RoundedRectangle(cornerRadius: Constants.cornerRaduis)
                            .fill(Color.black)
                            .shadow(color: Constants.baseColor.opacity(0.3), radius: 10))
                            
                
            })
        }
        .padding(Constants.contentPadding)
    }
}

#Preview {
    SettingsEventTimerView(type: .create)
}
