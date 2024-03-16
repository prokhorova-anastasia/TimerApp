//
//  MainScreenViewModel.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 28.09.2023.
//

import Foundation
import SwiftUI
import PhotosUI

final class MainScreenViewModel: ObservableObject {
    
    @Published var timerDataList: [TimerData] = []
    @Published var image: UIImage?
    
    private var allTimers: [TimerData] = []
    private var photoManager = PhotoManager()
    
    init() {
        getTimerDataList()
    }
    
    func getTimerDataList() {
//#if DEBUG
//        getTestTimers()
//#else
        allTimers = UserDefaultsManager.shared.getObjects(TimerData.self, forKey: .timersData) ?? []
        timerDataList = allTimers
//#endif
    }
    
    func removeAllTimersData() {
        UserDefaultsManager.shared.removeObject(forKey: .timersData)
        timerDataList = []
        allTimers = []
    }
    
    func removeTimerData(_ timerData: TimerData) {
        timerDataList.removeAll { timer in
            timer.id == timerData.id
        }
        
        allTimers.removeAll { timer in
            timer.id == timerData.id
        }
        UserDefaultsManager.shared.removeObject(forKey: .timersData)
        UserDefaultsManager.shared.saveObjects(timerDataList, forKey: .timersData)
    }
    
    func sortTimers() {
        timerDataList = allTimers.sorted { timer1, timer2 in
            timer2.targetDate > timer1.targetDate
        }
    }
    
    func filterTimersByText(_ text: String) {
        timerDataList = allTimers.filter({$0.title.contains(text)})
    }
    
    func getAllTimers() {
        timerDataList = allTimers
    }
    
    func loadImage(photoName: String) {
        photoManager.loadAssetImage(photoName: photoName) { [weak self] image, error in
            self?.image = image
        }
    }
    
    private func getTestTimers() {
        let timers = [
            TimerData(title: "Title1", description: "Description1", targetDate: Date().addingTimeInterval(3600), colorBackground: nil, photoName: nil),
            TimerData(title: "Title2", description: "Description2", targetDate: Date().addingTimeInterval(1000), colorBackground: "123456", photoName: nil),
            TimerData(title: "Title3", description: "Description3", targetDate: Date().addingTimeInterval(2000), colorBackground: "1234A6", photoName: nil),
            TimerData(title: "Title4", description: "Description4", targetDate: Date().addingTimeInterval(4000), colorBackground: "12E456", photoName: nil)
        ]
        timerDataList = timers
        allTimers = timers
    }
}
