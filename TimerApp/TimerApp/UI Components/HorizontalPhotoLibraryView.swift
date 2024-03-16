//
//  PhotosGridView.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 13.03.24.
//

import SwiftUI
import PhotosUI

struct AsyncImageView: View {
    
    @State var photoName: String?
    @State var viewModel = MainScreenViewModel()

    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Rectangle()
                    .fill(DSColor.violetTransparentSecond)
                    .overlay(
                        ProgressView()
                    )
            }
        }
        .cornerRadius(DSLayout.smallCornerRadius)
        .onAppear {
            if let name = photoName {
                viewModel.loadImage(photoName: name)
            }
        }
    }
}

#Preview {
    AsyncImageView()
}

