//
//  CreateEventChoosingImageView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 10.10.2023.
//

import SwiftUI
import PhotosUI

struct CreateEventChoosingImageView: View {
    
    @State var viewModel = MainScreenViewModel()
    @State var backgroundImageItem: PhotosPickerItem?
    @State var backgroundImage: UIImage?
    @ObservedObject var photoManager = PhotoManager.shared
    
    var body: some View {
        ZStack {
            if let image = backgroundImage {
                Image(uiImage: image)
                    .resizable()
            }
            HStack {
                titleView
                Spacer()
                chooseImageButtonView
            }
            .onChange(of: backgroundImageItem) { newItem in
                Task {
                    guard let imageData = try? await newItem?.loadTransferable(type: Data.self) else { return }
                        
                        backgroundImage = UIImage(data: imageData)
                    }
            }
        }
    }
    
    var titleView: some View {
        HStack {
            Text("choose_image")
                .foregroundStyle(DSColor.mainColor)
                .font(DSFont.body2)
            Spacer()
        }
    }
    
    var chooseImageButtonView: some View {
        VStack {
            if $photoManager.accessGranted.wrappedValue {
                PhotosPicker(selection: $backgroundImageItem, matching: .images) {
                    ZStack {
                        Image(systemName: "plus")
                            .foregroundStyle(DSColor.mainColor)
                            .frame(width: 44, height: 44)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                            .stroke(DSColor.mainColor, lineWidth: DSLayout.borderWidth)
                    )
                }
            } else {
                Button {
                    photoManager.requestPhotoLibraryAccess()
                } label: {
                    ZStack {
                        Image(systemName: "plus")
                            .foregroundStyle(DSColor.mainColor)
                            .frame(width: 44, height: 44)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                            .stroke(DSColor.mainColor, lineWidth: DSLayout.borderWidth))
                }
            }
        }
    }
}

#Preview {
    CreateEventChoosingImageView()
}
