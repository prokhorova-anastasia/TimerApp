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
        static let height: CGFloat = 48
    }
    
    @FocusState private var isFocused: Bool

    @State var placeholder: String
    @State var text: String = ""
    @Binding var isError: Bool
    
    var body: some View {
        ZStack {
            textField
                .padding(Constants.padding)
        }
        .background(
            RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                .stroke(isFocused ? DSColor.violetPrimary : (isError ? DSColor.errorColor : Color.clear), lineWidth: DSLayout.borderWidth)
        )
        .background(
            RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                .fill(DSColor.darkSecondary)
        )
    }
    
    private var textField: some View {

        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(DSColor.darkTertiary))
            .focused($isFocused)
            .font(DSFont.body1)
            .foregroundStyle(DSColor.white)
        
    }
}

#Preview {
    TextFieldView(placeholder: "Placeholder", isError: .constant(false))
}
