//
//  PhotoLibraryNotGrantedView.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 13.03.24.
//

import SwiftUI

struct PhotoLibraryNotGrantedView: View {
    
    private enum Constants {
        static let iconSize = CGSize(width: 26, height: 26)
        static let iconBackgroundSize = CGSize(width: 82, height: 82)
        static let iconBackgroundOpacity: CGFloat = 0.2
        static let buttonSize = CGSize(width: 164, height: 40)
    }
    
    @ObservedObject var photoManager = PhotoManagerLegacy()
    
    var body: some View {
        VStack(spacing: 8) {
            imageView
            VStack(spacing: 4) {
                titleView
                descriptionView
            }
            allowButtonView
        }
        .frame(width: 240)
    }
    
    private var imageView: some View {
        ZStack {
            Image("not_granded_icon")
                .frame(Constants.iconSize)
        }
        .frame(Constants.iconBackgroundSize)
        .background(
            RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                .fill(DSColor.violetPrimary.opacity(Constants.iconBackgroundOpacity))
        )
    }
    
    private var titleView: some View {
        Text("no_access_photo")
            .foregroundStyle(DSColor.white)
            .font(DSFont.title2)
            .multilineTextAlignment(.center)
    }
    
    private var descriptionView: some View {
        Text("no_access_photo_decription")
            .foregroundStyle(DSColor.darkTertiary)
            .font(DSFont.body2)
            .multilineTextAlignment(.center)
    }
    
    private var allowButtonView: some View {
        Button(action: {
            photoManager.requestPhotoLibraryAccess()
        }, label: {
            Text("allow_button")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.white)
                .frame(Constants.buttonSize)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                        .fill(DSColor.violetPrimary)
                )
        })
    }
}

#Preview {
    PhotoLibraryNotGrantedView()
}
