//
//  SettingsEventTimerView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import SwiftUI

struct SettingsEventTimerView: View {
    
    private enum Constants {
        static let contentPadding: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        static let contentSpacing: CGFloat = 36
        static let itemSpacing: CGFloat = 8
        static let cornerRaduis: CGFloat = 8
        static let itemPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }
    
    @EnvironmentObject var router: Router
    
    @State var titleString: String = ""
    @State var descriptionString: String = ""
    @State var choosedDate: Date = Date()
    
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemMint]
     UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemMint]
   }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.contentSpacing) {
                titleView
                descriptionView
                chooseDateView
                startButtonView
            }
        }
        .scrollIndicators(.hidden)
        .padding(Constants.contentPadding)
        .navigationTitle(Text("Create"))
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
        .foregroundColor(.mint)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var titleView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Title")
                    .foregroundStyle(.mint)
                Spacer()
            }
            TextField("", text: $titleString, prompt: Text("Type title...").foregroundColor(.mint.opacity(0.4)))
                .foregroundStyle(.mint.opacity(0.8))
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRaduis)
            .fill(Color.white)
            .shadow(color: .mint.opacity(0.3), radius: 5, x: 0, y: 5))
    }
    
    private var descriptionView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Description")
                    .foregroundStyle(.mint)
                Spacer()
            }
            TextField("", text: $descriptionString, prompt: Text("Type description...").foregroundColor(.mint.opacity(0.4)))
                .foregroundStyle(.mint.opacity(0.8))
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRaduis)
            .fill(Color.white)
            .shadow(color: .mint.opacity(0.3), radius: 5, x: 0, y: 5))
    }
    
    private var chooseDateView: some View {
        VStack(spacing: Constants.itemSpacing) {
            HStack {
                Text("Choose date")
                    .foregroundStyle(.mint)
                Spacer()
            }
            DatePicker("Choose date", selection: $choosedDate)
                .tint(.mint)
                .foregroundStyle(.mint)
                .datePickerStyle(.graphical)
        }
        .padding(Constants.itemPadding)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRaduis)
            .fill(Color.white)
            .shadow(color: .mint.opacity(0.3), radius: 5, x: 0, y: 5))
    }
    
    private var startButtonView: some View {
        HStack {
            Button(action: {
                router.navigateToBack()
            }, label: {
                Text("Create")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(
                        RoundedRectangle(cornerRadius: Constants.cornerRaduis)
                            .fill(Color.mint)
                            .shadow(color: .mint.opacity(0.3), radius: 10))
                            
                
            })
        }
        .padding(Constants.contentPadding)
    }
}

#Preview {
    SettingsEventTimerView()
}
