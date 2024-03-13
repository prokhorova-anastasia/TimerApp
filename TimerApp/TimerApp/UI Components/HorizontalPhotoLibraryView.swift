//
//  PhotosGridView.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 13.03.24.
//

import SwiftUI
import PhotosUI

struct AsyncImageView: View {
    
    private enum Constants {
        static let imageSize = CGSize(width: 100, height: 100)
        static let loadingImageSize = CGSize(width: 200, height: 200)
    }
    
    @State var image: UIImage?
    @ObservedObject var photoLibrary = PhotoLibrary()

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(DSColor.violetTransparentSecond)
                    .overlay(
                        ProgressView()
                    )
            }
        }
        .frame(Constants.imageSize)
        .cornerRadius(DSLayout.smallCornerRadius)
    }
}

struct HorizontalPhotoLibraryView: View {
    
    private enum Constants {
        static let spacing: CGFloat = 8
        static let loadingImageSize = CGSize(width: 200, height: 200)
        static let imageSize = CGSize(width: 100, height: 100)
        static let padding: CGFloat = 4
    }
    
    @ObservedObject var photoLibrary = PhotoLibrary()
    @Binding var selectedImage: UIImage?
    @State var selectedAsset: PHAsset?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constants.spacing) {
                ForEach(photoLibrary.images, id: \.self) { image in
                    AsyncImageView(image: image)
                        .background(
                            RoundedRectangle(cornerRadius: DSLayout.smallCornerRadius)
                                .stroke(selectedImage == image ? DSColor.violetPrimary : .clear, lineWidth: DSLayout.extraLargeBorderWidth)
                        )
                        .onTapGesture {
                            selectedImage = image
                        }
                }
            }
            .padding(Constants.padding)
        }
    }
}

#Preview {
    HorizontalPhotoLibraryView(selectedImage: .constant(nil))
}

