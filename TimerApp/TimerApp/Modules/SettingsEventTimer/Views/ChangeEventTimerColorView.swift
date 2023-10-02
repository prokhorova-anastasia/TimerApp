//
//  ChangeEventTimerColorView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 03.10.2023.
//

import SwiftUI

struct ChangeEventTimerColorView: View {
    
    private enum Constants {
        static let colorPadding: EdgeInsets = EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        static let contentSpacing: CGFloat = 8
    }
    
    @State var changeColorViewModel = ChangeColorViewModel()
    
    @State var selectedColor: Color = ChangeColorViewModel().colors[0]
    
    var body: some View {
        VStack(spacing: Constants.contentSpacing) {
            titleView
            colorListView
        }
    }
    
    private var titleView: some View {
        HStack {
            Text("chooseColor")
                .foregroundStyle(DSColor.mainColor)
                .font(DSFont.body1)
            Spacer()
        }
    }
    
    private var colorListView: some View {
        HStack {
            ForEach($changeColorViewModel.colors, id: \.self) { color in
                Circle()
                    .fill(color.wrappedValue == selectedColor ? color.wrappedValue : .clear)
                    .colorMultiply(color.wrappedValue)
                    .overlay {
                        Circle()
                            .fill(color.wrappedValue)
                            .padding(Constants.colorPadding)
                    }
                    .onTapGesture {
                        selectedColor = color.wrappedValue
                    }
            }
        }
    }
}

#Preview {
    ChangeEventTimerColorView()
}
