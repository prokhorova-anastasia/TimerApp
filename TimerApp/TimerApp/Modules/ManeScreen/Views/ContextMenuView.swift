//
//  ContextMenuView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.11.2023.
//

import SwiftUI

struct ContextMenuView: View {
    
    private enum Constants {
        static let contentWidth: CGFloat = 80
        static let imageWidth: CGFloat = 24
        static let dividerHeight: CGFloat = 1
    }
    
    var shareAction: (() -> ())
    var editAction: (() -> ())
    var deleteAction: (() -> ())
    
    var body: some View {
        VStack {
            shareView
            dividerView
            editView
            dividerView
            deleteView
        }
        .frame(width: Constants.contentWidth)
        .background(DSColor.darkSecondary)
    }
    
    var shareView: some View {
        GeometryReader { geometry in
            Button {
                shareAction()
            } label: {
                VStack(alignment: .center) {
                    Spacer()
                    Image("share_icon")
                        .resizable()
                        .frame(width: Constants.imageWidth, height: Constants.imageWidth)
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
        }
    }
    
    var editView: some View {
        GeometryReader { geometry in
            Button {
                editAction()
            } label: {
                VStack(alignment: .center) {
                    Spacer()
                    Image("edit_icon")
                        .resizable()
                        .frame(width: Constants.imageWidth, height: Constants.imageWidth)
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
        }
    }
    
    var deleteView: some View {
        GeometryReader { geometry in
            Button {
                deleteAction()
            } label: {
                VStack {
                    Spacer()
                    Image("delete_icon")
                        .resizable()
                        .frame(width: Constants.imageWidth, height: Constants.imageWidth)
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
        }
    }
    
    var dividerView: some View {
        Rectangle()
            .fill(DSColor.darkTertiary)
            .frame(height: Constants.dividerHeight)
    }
}

#Preview {
    ContextMenuView {
        print("share")
    } editAction: {
        print("edit")
    } deleteAction: {
        print("delete")
    }

}
