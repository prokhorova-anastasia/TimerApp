//
//  PhotoManager.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.10.2023.
//

import SwiftUI
import Photos
import PhotosUI

final class PhotoManager: ObservableObject {
    static let shared = PhotoManager()
    
    @Published var accessGranted: Bool = PHPhotoLibrary.authorizationStatus() == .authorized
    @Published var photos: [PhotoModel] = []
    
    var namePhotos: [String] = []
    
    private init() {}
    
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
    
    func saveImage(idString: String, imageItem: PhotosPickerItem?, completion: @escaping((Bool) -> ())) {
        guard let imageItem else { return }
        getImage(from: imageItem) { [weak self] image in
            guard let self else { return }
            guard let data = image?.jpegData(compressionQuality: 1) ?? image?.pngData() else {
                completion(false)
                return
            }
            
            if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = directory.appendingPathComponent("\(idString).png")
                do {
                    try data.write(to: fileURL)
                    self.namePhotos.append(idString)
                    self.photos.append(PhotoModel(id: idString, image: image))
                    completion(true)
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
            completion(false)
        }
    }
    
    func loadImage(idPhoto: String) -> UIImage? {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directory.appendingPathComponent("\(idPhoto).png")
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
    
    func loadImages() {
        guard let nameImages = UserDefaultsManager.shared.getData(forKey: .savedImages) as? [String] else { return }
        nameImages.forEach { name in
            let image = self.loadImage(idPhoto: name)
            self.photos.append(PhotoModel(id: name, image: image))
        }
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

struct PhotoModel: Identifiable {
    let id: String
    let image: UIImage?
}
