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
    
    let asset: PHAsset
    @State private var image: UIImage? = nil
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
        .onAppear {
//            image = photoLibrary.loadAssetImage(asset: asset)
            loadAssetImage()
        }
    }

    private func loadAssetImage() {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false

        PHImageManager.default().requestImage(for: asset, targetSize: Constants.loadingImageSize, contentMode: .aspectFill, options: options) { image, _ in
            DispatchQueue.main.async {
                self.image = image
            }
        }
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
                ForEach(photoLibrary.photos, id: \.self) { asset in
                    AsyncImageView(asset: asset)
                        .background(
                            RoundedRectangle(cornerRadius: DSLayout.smallCornerRadius)
                                .stroke(selectedAsset == asset ? DSColor.violetPrimary : .clear, lineWidth: DSLayout.extraLargeBorderWidth)
                        )
                        .onTapGesture {
                            loadAssetImage(asset: asset)
                            selectedAsset = asset
                        }
                }
            }
            .padding(Constants.padding)
        }
    }
    
    private func loadAssetImage(asset: PHAsset) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false

        PHImageManager.default().requestImage(for: asset, targetSize: Constants.loadingImageSize, contentMode: .aspectFill, options: options) { image, _ in
            DispatchQueue.main.async {
                selectedImage = image
            }
        }
    }
}

#Preview {
    HorizontalPhotoLibraryView(selectedImage: .constant(nil))
}

