//
//  PhotoLibrary.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 13.03.24.
//

import Foundation
import Photos
import SwiftUI

class PhotoLibrary: ObservableObject {
    @Published var photos = [PHAsset]()

    func loadPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        assets.enumerateObjects { (object, _, _) in
            self.photos.append(object)
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
}
