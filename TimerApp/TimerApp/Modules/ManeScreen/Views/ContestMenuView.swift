//
//  ContestMenuView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.11.2023.
//

import SwiftUI

struct ContestMenuView: View {
    
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
        .frame(width: 80)
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
                        .frame(width: 24, height: 24)
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
            .padding(0)
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
                        .frame(width: 24, height: 24)
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
            .padding(0)
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
                        .frame(width: 24, height: 24)
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
            .padding(0)
        }
    }
    
    var dividerView: some View {
        Rectangle()
            .fill(DSColor.darkTertiary)
            .frame(height: 1)
    }
}

#Preview {
    ContestMenuView {
        print("share")
    } editAction: {
        print("edit")
    } deleteAction: {
        print("delete")
    }

}
