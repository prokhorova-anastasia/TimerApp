//
//  QuiclyJumpToDateView.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 12.03.24.
//

import SwiftUI

struct GoToDateModel {
    let months: Int
    let weeks: Int
    let days: Int
}

struct QuiclyJumpToDateView: View {
    
    private enum Constants {
        static let contentSpacing: CGFloat = 24
        static let textSpacing: CGFloat = 4
        static let contentPadding: CGFloat = 24
        static let dividerSize = CGSize(width: 50, height: 4)
    }
    
    var buttonTapped: ((GoToDateModel) -> ())?
    
    @State private var months: Int = 0
    @State private var weeks: Int = 0
    @State private var days: Int = 0
    
    var body: some View {
            VStack(spacing: Constants.contentSpacing) {
                dividerView
                VStack(spacing: Constants.textSpacing) {
                    titleView
                    descriptionView
                }
                wheelsView
                buttonView
            }
            .padding(Constants.contentPadding)
            .background(DSColor.darkSecondary)
    }
    
    private var dividerView: some View {
        RoundedRectangle(cornerRadius: DSLayout.smallCornerRadius)
            .fill(DSColor.violetTertiary)
            .frame(Constants.dividerSize)
    }
    
    private var titleView: some View {
        HStack {
            Text("quickly_jump_to_date_title")
                .font(DSFont.headline2)
                .foregroundStyle(DSColor.white)
            Spacer()
        }
    }
    
    private var descriptionView: some View {
        HStack {
            Text("quickly_jump_to_date_description")
                .font(DSFont.body2)
                .foregroundStyle(DSColor.darkTertiary)
            Spacer()
        }
    }
    
    private var wheelsView: some View {
        HStack {
            Picker("", selection: $months) {
                ForEach(0...100, id: \.self) { number in
                    Text("\(number)")
                        .foregroundStyle(DSColor.white)
                        .font(DSFont.title1)

                }
            }
            .pickerStyle(.wheel)
            
            Text("months_abbreviation")
                .foregroundStyle(DSColor.white)
                .font(DSFont.title1)
            
            Picker("", selection: $weeks) {
                ForEach(0...100, id: \.self) { number in
                    Text("\(number)")
                        .foregroundStyle(DSColor.white)
                        .font(DSFont.title1)

                }
            }
            .pickerStyle(.wheel)
            
            Text("weeks_abbreviation")
                .foregroundStyle(DSColor.white)
                .font(DSFont.title1)
            
            Picker("", selection: $days) {
                ForEach(0...100, id: \.self) { number in
                    Text("\(number)")
                        .foregroundStyle(DSColor.white)
                        .font(DSFont.title1)

                }
            }
            .pickerStyle(.wheel)
            
            Text("days_abbreviation")
                .foregroundStyle(DSColor.white)
                .font(DSFont.title1)

        }
    }
    
    private var buttonView: some View {
        Button(action: {
            buttonTapped?(GoToDateModel(months: months, weeks: weeks, days: days))
        }, label: {
            Text("jump_to_date")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.white)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                        .fill(DSColor.violetPrimary)
                )
        })
    }
}

#Preview {
    QuiclyJumpToDateView()
}
