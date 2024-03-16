//
//  TimerEditorViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import UIKit
import SwiftUI

final class TimerEditorViewModel: ObservableObject {
    
    private let photoManager = PhotoManager()
    
    @Published var images: [ImageModel] = []
    
    func saveTimer(title: String, description: String?, targetDate: Date, colorBackground: String?, imageName: String?) {
        UserDefaultsManager.shared.saveBoolData(true, forKey: .wasTimerCreated)
        let newTimerData = TimerData(title: title, description: description, targetDate: targetDate, colorBackground: colorBackground, photoName: imageName)
        if var array = UserDefaultsManager.shared.getObjects(TimerData.self, forKey: .timersData), !array.isEmpty {
            array.append(newTimerData)
            UserDefaultsManager.shared.saveObjects(array, forKey: .timersData)
        } else {
            UserDefaultsManager.shared.saveObjects([newTimerData], forKey: .timersData)
        }
    }
    
    func updateTimer(timerData: TimerData) {
        if var array = UserDefaultsManager.shared.getObjects(TimerData.self, forKey: .timersData), !array.isEmpty {
            guard let index = array.firstIndex(where: {$0.id == timerData.id})  else { return }
            array.remove(at: index)
            array.append(timerData)
            UserDefaultsManager.shared.saveObjects(array, forKey: .timersData)
        }
    }
    
    func loadImages() {
        photoManager.loadImages { [weak self] images, error in
            self?.images = images
        }
    }
}
