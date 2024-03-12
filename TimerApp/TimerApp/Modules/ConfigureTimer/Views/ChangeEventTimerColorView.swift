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
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var changeColorViewModel = ChangeColorViewModel()
    
    @Binding var selectedColor: Color
    
    @State var viewModel = MainScreenViewModel()
    
    var body: some View {
        VStack(spacing: Constants.contentSpacing) {
            titleView
//            colorListView
//                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
        }
    }
    
    private var titleView: some View {
        HStack {
            Text("choose_color")
                .foregroundStyle(DSColor.mainColor)
                .font(DSFont.body1)
            Spacer()
        }
    }
    
//    private var colorListView: some View {
//        HStack {
//            ForEach(ChangeColorViewModel().colors, id: \.self) { color in
//                ZStack {
//                    Image(systemName: "a.square.fill")
//                        .resizable()
//                        .foregroundStyle(color.wrappedValue)
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 4)
//                                .strokeBorder(color.wrappedValue == $selectedColor.wrappedValue ? DSColor.mainColor :  DSColor.modalColor, lineWidth: color.wrappedValue == $selectedColor.wrappedValue ? 1 : 0.5)
//                        }
//                }
//                .frame(width: 24, height: 24)
//                .background(
//                    RoundedRectangle(cornerRadius: 4)
//                        .fill(getTextColorFor(color.wrappedValue))
//                )
//                .onTapGesture {
//                    selectedColor = color.wrappedValue
//                }
//            }
//        }
//    }
    
    func getTextColorFor(_ color: Color) -> Color {
        if color == DSColor.backgroundColor {
            return colorScheme == .dark ? DSColor.TechColor.lightMainColor : DSColor.TechColor.darkMainColor
        }
        
        return color.isDark ? DSColor.TechColor.lightTextColorTimer : DSColor.TechColor.darkMainColor
    }
}

#Preview {
    ChangeEventTimerColorView(selectedColor: .constant(DSColor.backgroundColor))
}

extension Color {
    var isDark: Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return false
        }
        
        let lum = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return lum < 0.5
    }
}
