//
//  SettingsEventTimerView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import SwiftUI
import PhotosUI

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
    @State var isValidate: Bool = true
    @State var selectedColor: Color = DSColor.backgroundColor
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: Constants.contentSpacing) {
                    titleView
                    descriptionView
                    chooseDateView
                    changeColorView
                    choosingImageView
                }
                .padding(Constants.itemPadding)
            }
            .scrollIndicators(.hidden)
            createButtonView
                .padding(Constants.buttonPadding)
        }
        .padding(Constants.contentPadding)
        .navigationTitle(Text(type == .create ? "create" : "update"))
        .foregroundColor(DSColor.mainColor)
        .toolbar(.visible, for: .navigationBar)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.navigateToBack()
                }, label: {
                    Text("back")
                        .font(DSFont.body1)
                        .foregroundStyle(DSColor.mainColor)
                })
                .padding(.leading, Constants.oneSidePadding)
            }
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.automatic)
        .background(DSColor.backgroundColor)
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
                Text("title")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Spacer()
            }
            TextField("", text: $titleString, prompt: Text("type_title")
                .foregroundColor(DSColor.mainColor.opacity(Constants.middleOpacity)))
            .foregroundStyle(DSColor.mainColor.opacity(Constants.highOpacity))
            .font(DSFont.body1)
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
            .stroke(!isValidate ? DSColor.errorColor : DSColor.mainColor, lineWidth: DSLayout.borderWidth)
            )
    }
    
    private var descriptionView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("description")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Spacer()
            }
            TextField("", text: $descriptionString, prompt: Text("type_description")
                .foregroundColor(DSColor.mainColor.opacity(Constants.middleOpacity)))
            .foregroundStyle(DSColor.mainColor.opacity(Constants.highOpacity))
            .font(DSFont.body1)
            
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
            .stroke(DSColor.mainColor, lineWidth: DSLayout.borderWidth)
        )
    }
    
    private var chooseDateView: some View {
            HStack {
                Text("choose_date")
                    .foregroundStyle(DSColor.mainColor)
                    .font(DSFont.body2)
                Spacer()
                DatePicker("", selection: $choosedDate)
                    .tint(DSColor.mainColor)
                    .foregroundStyle(DSColor.mainColor)
                    .datePickerStyle(.compact)
            }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
            .stroke(DSColor.mainColor, lineWidth: DSLayout.borderWidth)
            )
    }
    
    private var changeColorView: some View {
        ChangeEventTimerColorView(selectedColor: $selectedColor)
            .padding(Constants.itemPadding)
            .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                .stroke(DSColor.mainColor, lineWidth: DSLayout.borderWidth)
                )
    }
    
    private var createButtonView: some View {
        HStack {
            Button(action: {
                if checkValidation() {
                    switch type {
                    case .create:
                        viewModel.saveEventTimer(title: titleString, description: descriptionString, targetDate: choosedDate,
                                                 colorBackground: selectedColor.hexString)
                    case .updateType:
#warning("Поменять обработку нила для eventTimer. Например: если еventTimer = nil и type == .update, то показывать ошибку")
                        guard let event = eventTimer else { return}
                        var newEvent  = event
                        newEvent.title = titleString
                        newEvent.description = descriptionString
                        newEvent.targetDate = choosedDate
                        viewModel.updateEventTimer(eventTimer: newEvent)
                        router.navigateToBack()
                    }
                    router.navigateToBack()
                }
                
            }, label: {
                Text(type == .create ? "create" : "update")
                    .foregroundStyle(DSColor.buttonTextColor)
                    .frame(maxWidth: .infinity, minHeight: Constants.heightCreateButton, maxHeight: Constants.heightCreateButton)
                    .background(
                        RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                            .fill(DSColor.buttonColor)
                            )
                    .font(DSFont.title1)
            })
        }
        .padding(Constants.contentPadding)
    }
    
    private var choosingImageView: some View {
        CreateEventChoosingImageView()
            .padding(Constants.itemPadding)
            .background(RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                .stroke(DSColor.mainColor, lineWidth: DSLayout.borderWidth)
                )
    }
    
    private func checkValidation() -> Bool {
        isValidate = !titleString.isEmpty
        return isValidate
    }
}

#Preview {
    SettingsEventTimerView(type: .create, selectedColor: DSColor.backgroundColor)
}
