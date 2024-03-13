//
//  PhotoLibrary.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 13.03.24.
//

import Foundation
import Photos
import SwiftUI
import PhotosUI

final class PhotoLibrary: ObservableObject {
    @Published var photos: [PHAsset] = []
    @Published var images: [UIImage?] = []

    func loadPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        assets.enumerateObjects { [weak self] (object, _, _) in
            guard let self else { return }
            self.photos.append(object)
            self.loadAssetImage(asset: object) { image in
                self.images.append(image)
            }
        }
    }

    init() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.loadPhotos()
                }
            }
        }
    }
    
    func loadAssetImage(asset: PHAsset, completion: @escaping ((UIImage?) -> ())) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: options) { image, _ in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
