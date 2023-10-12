//
//  PhotoManager.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 12.10.2023.
//

import SwiftUI
import Photos

final class PhotoManager: ObservableObject {
    static let shared = PhotoManager()
    
    @Published var accessGranted: Bool = false
    
    private init() {}
    
    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            accessGranted = true
        case .denied, .restricted :
            accessGranted = false
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self.accessGranted = true
                    } else {
                        self.accessGranted = false
                    }
                }
            }
        default:
            accessGranted = false
        }
    }
    
    func showSettingsAlert() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Открытие настроек: \(success)")
            })
        }
    }
}
