//
//  TimerEditorView.swift
//  TimerApp
//
//  Created by Anastasia Prokhorova on 14.11.2023.
//

import SwiftUI
import PhotosUI

struct TimerEditorView: View {
    
    private enum BackgroundType: String, CaseIterable {
        case photo = "Photo"
        case color = "Color"
    }
    
    private enum Constants {
        static let contentPadding: CGFloat = 16
        static let statusBarHeight: CGFloat = 44; #warning("поправить для высчитывания высоты статус бара")
        static let navigationContentPadding: CGFloat = 16
        static let spacingComponent: CGFloat = 8
        static let horizontalPaddingSpacing: CGFloat = 16
        static let buttonHeight: CGFloat = 40
        static let contentSpacing: CGFloat = 24
        static let buttonsDateSpacing: CGFloat = 16
        static let minimumDistance: CGFloat = 5
        static let navigationContentSpacing: CGFloat = 16
        static let backIconSize = CGSize(width: 16, height: 16)
        static let backButtonPadding: CGFloat = 12
        static let colorSize = CGSize(width: 30, height: 30)
        static let colorSpacing: CGFloat = 24
        static let colorPadding: CGFloat = 4
    }
    
    @EnvironmentObject var router: Router
    @State var type: SettingsType
    @State var timerData: TimerData?
    @State var titleString: String = ""
    @State var descriptionString: String = ""
    @State var selectedDate = Date()
    @ObservedObject var viewModel = TimerEditorViewModel()
    
    @State private var selectedBackground: BackgroundType = .photo
    @State private var isGoToDateHidden = true
    @State private var selectedColorIndex = 0
    @State private var selectedColorHex: String = DSColor.violetSecondary.hexString
    @ObservedObject private var changeColorViewModel = ChangeColorViewModel()
    @State private var selectedAsset: UIImage? = nil
    @State private var backgroundImageItem: PhotosPickerItem?
    @State private var backgroundImage: UIImage?
    @State private var selectedImage: UIImage?
    @State private var selectedNameImage: String?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                navigationBarView
                ScrollView {
                    VStack(spacing: Constants.contentSpacing) {
                        titleView
                        descriptionView
                        dateView
                        HStack(spacing: Constants.buttonsDateSpacing) {
                            setTodayButton
                                .frame(maxWidth: .infinity)
                            chooseDateButton
                                .frame(maxWidth: .infinity)
                        }
                        selectorTimerBackground
                        choosingBackgroundView
                        Spacer()
                        createButtonView
                    }
                    .padding(Constants.contentPadding)
                }
            }
            .background(DSColor.darkPrimary)
            .toolbar(.hidden, for: .navigationBar)
            
            if !isGoToDateHidden {
                QuiclyJumpToDateView { model in
                    withAnimation {
                        goToDate(dateModel: model)
                        isGoToDateHidden.toggle()
                    }
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                )
                .zIndex(1)
                .transition(.move(edge: isGoToDateHidden ? .top : .bottom))
                .gesture(DragGesture(minimumDistance: Constants.minimumDistance, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.height > 0 {
                            withAnimation {
                                isGoToDateHidden.toggle()
                            }
                        }
                    }))
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.loadImages()
        }
    }
    
    private var navigationBarView: some View {
        VStack {
            HStack {
            }
            .frame(height: Constants.statusBarHeight)
            VStack {
                HStack(spacing: Constants.navigationContentSpacing) {
                    backButtonView
                    Text("new_timer")
                        .font(DSFont.headline1)
                        .foregroundStyle(DSColor.white)
                    Spacer()
                }
            }
            .padding(Constants.navigationContentPadding)
        }
    }
    
    private var backButtonView: some View {
        Button {
            router.navigateToBack()
        } label: {
            Image("back_icon")
                .frame(Constants.backIconSize)
                .padding(Constants.backButtonPadding)
        }
        .background(
            Circle()
                .fill(DSColor.darkTransparentPrimary)
        )
    }
    
    private var titleView: some View {
        VStack(spacing: Constants.spacingComponent) {
            HStack {
                Text("title")
                    .font(DSFont.title1)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            TextFieldView(placeholder: String(localized: "title"), text: $titleString, isError: .constant(false))
        }
    }
    
    private var descriptionView: some View {
        VStack(spacing: Constants.spacingComponent) {
            HStack {
                Text("description")
                    .font(DSFont.title1)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            TextFieldView(placeholder:
                            String(localized: "description"), text: $descriptionString, isError: .constant(false), lineLimit: 3)
        }
    }
    
    private var dateView: some View {
        VStack(spacing: Constants.spacingComponent) {
            HStack {
                Text("date")
                    .font(DSFont.title1)
                    .foregroundStyle(DSColor.white)
                Spacer()
            }
            ChoosingDateView(selectedDate: $selectedDate)
        }
    }
    
    private var setTodayButton: some View {
        Button(action: {
            selectedDate = Date()
        }, label: {
            Text("set_today")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.darkTertiary)
                .padding(.horizontal, Constants.horizontalPaddingSpacing)
                .frame(height: Constants.buttonHeight)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                        .stroke(DSColor.darkTertiary, lineWidth: DSLayout.borderWidth)
                )
        })
    }
    
    private var chooseDateButton: some View {
        Button(action: {
            withAnimation {
                isGoToDateHidden.toggle()
            }
        }, label: {
            Text("go_to_date")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.darkTertiary)
                .padding(.horizontal, Constants.horizontalPaddingSpacing)
                .frame(height: Constants.buttonHeight)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                        .stroke(DSColor.darkTertiary, lineWidth: DSLayout.borderWidth)
                )
        })
    }
    
    private var selectorTimerBackground: some View {
        Picker("", selection: $selectedBackground) {
            ForEach(BackgroundType.allCases, id: \.self) {
                Text($0.rawValue)
                    .foregroundStyle(DSColor.white)
            }
        }
        .pickerStyle(.segmented)
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(DSColor.violetPrimary)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(DSColor.white), .font: DSFont.UICustomFont.body3], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(DSColor.darkTertiary), .font: DSFont.UICustomFont.body3], for: .normal)

        }
    }
    
    private var choosingBackgroundView: some View {
        VStack {
            switch selectedBackground {
            case .photo:
                choosingPhotoView
            case .color:
                choosingColorView
            }
        }
    }
    
    private var choosingPhotoView: some View {
        VStack {
            if !viewModel.getPhotoGranded() {
                notGrandedView
            } else {
                if !viewModel.images.isEmpty {
                    photosView
                }
                openGaleryButton
            }
        }
    }
    
    private var photosView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach($viewModel.images, id: \.id) { imageModel in
                    if let image = imageModel.image.wrappedValue {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 90, height: 100)
                            .cornerRadius(DSLayout.cornerRadius)
                            .background(
                                RoundedRectangle(cornerRadius: DSLayout.cornerRadius)
                                    .stroke(selectedImage == image ? DSColor.violetPrimary : .clear, lineWidth: DSLayout.extraLargeBorderWidth)
                            )
                            .onTapGesture {
                                selectedImage = image
                                selectedNameImage = imageModel.id
                            }
                    }
                }
            }
            .padding(4)
        }
    }
    
    private var openGaleryButton: some View {
        PhotosPicker(selection: $backgroundImageItem, matching: .images) {
            ZStack {
                Text("open_galery")
                    .foregroundStyle(DSColor.white)
                    .font(DSFont.body3)
                    .frame(width: 164, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                            .fill(DSColor.violetPrimary)
                    )
            }
        }
        .onChange(of: backgroundImageItem) { newItem in
            if let item = newItem {
                viewModel.saveImage(photoName: UUID().uuidString, item: item) { error in
                    if let error {
                        print("Error \(error)")
                    } else {
                        print("Image saved")
                    }
                }
            }
        }
    }
    
    private var notGrandedView: some View {
        PhotoLibraryNotGrantedView()
    }
    
    private var choosingColorView: some View {
        HStack(spacing: Constants.colorSpacing) {
            ForEach(Array(changeColorViewModel.colors.enumerated()), id: \.element.id) { ind, color in
                Circle()
                    .fill(color.color)
                    .frame(Constants.colorSize)
                    .padding(Constants.colorPadding)
                    .overlay(
                        RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                            .stroke(selectedColorIndex == ind ? color.color : Color.clear, lineWidth: DSLayout.largeBorderWidth)
                    )
                    .onTapGesture {
                        selectedColorIndex = ind
                        selectedColorHex = color.color.hexString
                    }
            }
        }
    }
    
    private var createButtonView: some View {
        Button {
            viewModel.saveTimer(title: titleString, description: descriptionString, targetDate: selectedDate, colorBackground: selectedColorHex, imageName: selectedNameImage)
            router.navigateToBack()
        } label: {
            Text("create")
                .font(DSFont.body3)
                .foregroundStyle(DSColor.white)
                .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                .background(
                    RoundedRectangle(cornerRadius: DSLayout.extraLargeCornerRadius)
                        .fill(DSColor.violetPrimary)
                )
        }

    }
    
    private func goToDate(dateModel: GoToDateModel) {
        let dateDays = Calendar.current.date(byAdding: .day, value: dateModel.days, to: Date())
        let dateWeeks = Calendar.current.date(byAdding: .weekOfMonth, value: dateModel.weeks, to: dateDays ?? Date())
        let dateMonths = Calendar.current.date(byAdding: .month, value: dateModel.months, to: dateWeeks ?? Date())
        selectedDate = dateMonths ?? Date()
    }
}

#Preview {
    TimerEditorView(type: .create)
}



