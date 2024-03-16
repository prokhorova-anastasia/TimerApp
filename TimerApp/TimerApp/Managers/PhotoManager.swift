//
//  PhotoManager.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 16.03.24.
//

import Foundation
import SwiftUI
import PhotosUI
import Combine

final class PhotoManager: ObservableObject {
    
    var accessGranted: Bool = PHPhotoLibrary.authorizationStatus() == .authorized
//    var photos: [ImageModel] = []
    var image: UIImage?
    var photos = CurrentValueSubject<[ImageModel], Never>([])
    
    var namePhotos: [String] = []
    
    func saveImage(photoName: String, item: PhotosPickerItem?, completion: @escaping((Error?) -> ())) {
        guard let item else {
            completion(AppError.imageSavedError)
            return
        }
        
        let photosName = photos.value.map({ $0.id })
        
        guard !photosName.contains(photoName) else { return }
        
        getImage(from: item) { [weak self] image, error in
            
            guard error == nil else {
                completion(error)
                return
            }
            guard let self else {
                completion(AppError.imageSavedError)
                return
            }
            guard let data = image?.jpegData(compressionQuality: 1) ?? image?.pngData() else {
                completion(AppError.imageSavedError)
                return
            }
            
            if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = directory.appendingPathComponent("\(photoName).png")
                do {
                    try data.write(to: fileURL)
                    self.namePhotos.append(photoName)
                    self.photos.value.append(ImageModel(id: photoName, image: image))
                    self.saveNamePhotos()
                    completion(nil)
                } catch {
                    completion(error)
                }
            }
            completion(AppError.imageSavedError)
        }
    }
    
    func loadAssetImage(photoName: String, completion: @escaping((UIImage?, Error?) -> ())) {
        if let cachedImage = ImageCache.getImage(forKey: photoName) {
            completion(cachedImage, nil)
        }
        
        loadImage(photoName: photoName) { image, error in
            completion(image, error)
        }
    }
    
    func loadImages(completion: @escaping(([ImageModel], Error?) -> ())) {
        guard let nameImages = UserDefaultsManager.shared.getData(forKey: .savedImages) as? [String] else {
            completion([], AppError.imageLoadedError)
            return
        }
        
        var images: [ImageModel] = []
        
        nameImages.forEach { [weak self] name in
            guard let self else { return }
            self.loadAssetImage(photoName: name) { image, error in
                guard let image = image else { return }
                images.append(ImageModel(id: name, image: image))
                self.namePhotos.append(name)
                self.photos.value.append(ImageModel(id: name, image: image))
            }
        }
        completion(images, nil)
    }
    
    private func loadImage(photoName: String, completion: @escaping((UIImage?, Error?) -> ())) {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(nil, AppError.imageLoadedError)
            return
        }
        let fileURL = directory.appendingPathComponent("\(photoName).png")
        guard let imageData = try? Data(contentsOf: fileURL) else {
            completion(nil, AppError.imageLoadedError)
            return
        }
        guard let image = UIImage(data: imageData) else {
            completion(nil, AppError.imageLoadedError)
            return
        }
        ImageCache.setImage(image, forKey: photoName)
        completion(image, nil)
    }
    
    private func saveNamePhotos() {
        UserDefaultsManager.shared.saveData(namePhotos, forKey: .savedImages)
    }
    
    private func getImage(from imageItem: PhotosPickerItem, completion: @escaping((UIImage?, Error?) ->())) {
        Task {
            guard let imageData = try? await imageItem.loadTransferable(type: Data.self) else {
                completion(nil, AppError.imageGettingError)
                return
            }
            let image = UIImage(data: imageData)
            completion(image, nil)
        }
    }
}

// MARK: Access granted
extension PhotoManager {
    
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
}
