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
        static let itemPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        static let buttonPadding: EdgeInsets = EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16)
        static let oneSidePadding: CGFloat = 8
        static let lowOpacity: CGFloat = 0.3
        static let middleOpacity: CGFloat = 0.4
        static let highOpacity: CGFloat = 0.8
        static let heightCreateButton: CGFloat = 44
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
        .foregroundColor(DSColor.mainColor)
        .toolbar(.visible, for: .navigationBar)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.navigateToBack()
                }, label: {
                    Text("Back")
                        .font(DSFont.body1)
                        .foregroundStyle(DSColor.mainColor)
                })
                .padding(.leading, Constants.oneSidePadding)
            }
        })
        .navigationBarBackButtonHidden()
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
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Spacer()
            }
            TextField("", text: $titleString, prompt: Text("Type title...")
                .foregroundColor(DSColor.mainColor.opacity(Constants.middleOpacity)))
            .foregroundStyle(DSColor.mainColor.opacity(Constants.highOpacity))
            .font(DSFont.body1)
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
//            .fill(Color.white)
            .stroke(DSColor.mainColor, lineWidth: 1)
            )
    }
    
    private var descriptionView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Description")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Spacer()
            }
            TextField("", text: $descriptionString, prompt: Text("Type description...")
                .foregroundColor(DSColor.mainColor.opacity(Constants.middleOpacity)))
            .foregroundStyle(DSColor.mainColor.opacity(Constants.highOpacity))
            .font(DSFont.body1)
            
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                    //            .fill(Color.white)
            .stroke(DSColor.mainColor, lineWidth: 1)
        )
    }
    
    private var chooseDateView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Choose date")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Spacer()
            }
            DatePicker("", selection: $choosedDate)
                .tint(.black)
                .foregroundStyle(DSColor.mainColor)
                .datePickerStyle(.graphical)
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
//            .fill(Color.white)
            .stroke(DSColor.mainColor, lineWidth: 1)
            )
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
                    .foregroundStyle(DSColor.buttonTextColor)
                    .frame(maxWidth: .infinity, minHeight: Constants.heightCreateButton, maxHeight: Constants.heightCreateButton)
                    .background(
                        RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                            .fill(DSColor.buttonColor)
                            )
                    .font(DSFont.bodySemibold1)
            })
        }
        .padding(Constants.contentPadding)
    }
}

#Preview {
    SettingsEventTimerView(type: .create)
}
