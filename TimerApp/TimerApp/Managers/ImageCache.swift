//
//  ImageCache.swift
//  TimerApp
//
//  Created by Анастасия Прохорова on 16.03.24.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()

    static func getImage(forKey key: String) -> UIImage? {
        return shared.object(forKey: NSString(string: key))
    }

    static func setImage(_ image: UIImage, forKey key: String) {
        shared.setObject(image, forKey: NSString(string: key))
    }
}
