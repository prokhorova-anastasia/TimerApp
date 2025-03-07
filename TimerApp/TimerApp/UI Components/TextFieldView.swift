//
//  TextFieldView.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 12.03.24.
//

import SwiftUI

struct TextFieldView: View {
    
    private enum Constants {
        static let padding: CGFloat = 16
    }
    
    @FocusState private var isFocused: Bool

    @State var placeholder: String
    @Binding var text: String
    @Binding var isError: Bool
    @State var lineLimit: Int = 1
    
    var body: some View {
        VStack {
            textField
                .padding(Constants.padding)
        }
        .background(
            RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                .stroke(isFocused ? DSColor.violetPrimary : (isError ? DSColor.errorPrimary : Color.clear), lineWidth: DSLayout.borderWidth)
        )
        .background(
            RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                .fill(DSColor.darkSecondary)
        )
    }
    
    private var textField: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(DSColor.darkTertiary), axis: .vertical)
            .focused($isFocused)
            .font(DSFont.body1)
            .foregroundStyle(DSColor.white)
            .lineLimit(lineLimit)
    }
}

#Preview {
    TextFieldView(placeholder: "Placeholder", text: .constant("dsljsldk"), isError: .constant(false), lineLimit: 5)
}
