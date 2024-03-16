//
//  PhotoManagerLegacy.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.10.2023.
//

import SwiftUI
import Photos
import PhotosUI

final class PhotoManagerLegacy: ObservableObject {
    
    @Published var accessGranted: Bool = PHPhotoLibrary.authorizationStatus() == .authorized
    @Published var photos: [ImageModel] = []
    @Published var image: UIImage?
    
    var namePhotos: [String] = []
        
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            accessGranted = true
        case .denied, .restricted:
            accessGranted = false
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self?.accessGranted = true
                    } else {
                        self?.accessGranted = false
                    }
                }
            }
        default:
            accessGranted = false
        }
    }
    
    func showSettingsAlert() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Открытие настроек: \(success)")
            })
        }
    }
    
    func saveImage(photoName: String, imageItem: PhotosPickerItem?, completion: @escaping((Bool) -> ())) {
        guard let imageItem else { return }
        getImage(from: imageItem) { [weak self] image in
            guard let self else { return }
            guard let data = image?.jpegData(compressionQuality: 1) ?? image?.pngData() else {
                completion(false)
                return
            }
            
            if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = directory.appendingPathComponent("\(photoName).png")
                do {
                    try data.write(to: fileURL)
                    self.namePhotos.append(photoName)
                    self.photos.append(ImageModel(id: photoName, image: image))
                    self.saveNamePhotos()
                    completion(true)
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
            completion(false)
        }
    }
    
    func loadImage(photoName: String) -> UIImage? {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directory.appendingPathComponent("\(photoName).png")
            if let imageData = try? Data(contentsOf: fileURL) {
                if let image = UIImage(data: imageData) {
                    ImageCache.setImage(image, forKey: photoName)
                    return image
                } else {
                    return nil
                }
            }
        }
        return nil
    }
    
    func loadAssetImage(photoName: String) -> UIImage? {
        if let cachedImage = ImageCache.getImage(forKey: photoName) {
            self.image = cachedImage
            return cachedImage
        }
        
        return loadImage(photoName: photoName)
    }
    
    private func saveNamePhotos() {
        UserDefaultsManager.shared.saveData(namePhotos, forKey: .savedImages)
    }
    
    private func getImage(from imageItem: PhotosPickerItem, completion: @escaping((UIImage?) ->())) {
        Task {
            guard let imageData = try? await imageItem.loadTransferable(type: Data.self) else { return }
            let image = UIImage(data: imageData)
            completion(image)
        }
    }
}
