//
//  ProfileScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 12/12/24.
//

import SwiftUI
import UIKit
import PhotosUI
import Kingfisher

struct ProfileScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    
    @StateObject var viewModel = ProfileViewModel()
    
    @AppStorage("theme") var appearance: ColorScheme = .light
    
    @State private var showPhotoPicker = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    makeProfileView(profile: viewModel.profile)
                    VStack(spacing: 0) {
                        if KeychainManager.shared.isIdentified {
                            ForEach(ProfileModel.Setting.allCases, id: \.self) { setting in
                                Button(action: {
                                    viewModel.route(to: setting.route)
                                }, label: {
                                    makeSettingView(setting: setting)
                                })
                                Divider()
                            }
                        }
                        HStack {
                            Image(systemName: "circle.lefthalf.filled.inverse")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(themeManager.colors.textNeutral2)
                            Text("Темная тема")
                                .foregroundStyle(themeManager.colors.textNeutral2)
                            Toggle("", isOn: .init(get: {
                                appearance == .dark
                            }, set: { isDark in
                                changeTheme(to: isDark ? .dark : .light)
                            }))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 60)
                    }
                }
                .padding()
            }
            if KeychainManager.shared.isAuthenticated {
                footerView
                    .padding()
            }
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPickerView(selectedImage: $viewModel.selectedImage)
                .ignoresSafeArea()
        }
        .navigationTitle(stringsManager.strings.profileName)
        .background(themeManager.colors.bgNeutral1)
        .onAppear {
            viewModel.getProfile()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !KeychainManager.shared.isAuthenticated {
                    Text("Войти")
                        .foregroundStyle(themeManager.colors.textOnBrand)
                        .frame(width: 80, height: 32, alignment: .center)
                        .background(themeManager.colors.bgBrand1)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            AuthenticationService.shared.status = .unauthenticated
                        }
                }
            }
        }
        
    }
    
    
    @ViewBuilder
    private func makeProfileView(profile: ProfileModel.Profile) -> some View {
        HStack (spacing: 12) {
            Button {
                showPhotoPicker = true
            } label: {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(square: 40)
                        .clipShape(.circle)
                }
                else if let avatar = profile.avatar {
                    KFImage(URL(string: avatar))
                        .placeholder({ _ in
                            ProgressView()
                                .tint(themeManager.colors.textNeutral4)
                                .frame(square: 40, alignment: .center)
                        })
                        .resizable()
                        .frame(square: 40)
                        .background(themeManager.colors.bgNeutral2)
                        .clipShape(.circle)
                        .onAppear(perform: {
                            print(avatar)
                        })
                }
                else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(square: 40)
                        .foregroundStyle(themeManager.colors.textNeutral4)
                        .background(themeManager.colors.bgNeutral3)
                        .clipShape(.circle)
                }
            }

            VStack(alignment: .leading, spacing: 4){
                Text(profile.name)
                    .fontWeight(.bold)
                    .foregroundStyle(themeManager.colors.textNeutral2)
                Text(profile.number)
                    .foregroundStyle(themeManager.colors.textDisabled)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
    }
    @ViewBuilder
    private func makeSettingView(setting: ProfileModel.Setting) -> some View {
        HStack {
            setting.icon
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(themeManager.colors.textNeutral2)
            Text(setting.title(for: stringsManager.strings))
                .foregroundStyle(themeManager.colors.textNeutral2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
    }
    
    var footerView: some View {
        Button("Выйти") {
            viewModel.isExitDialogPresented = true
        }
        .confirmationDialog(
            "Выход из аккаунта",
            isPresented: $viewModel.isExitDialogPresented,
            titleVisibility: .visible
        ) {
            Button("Да, выйти", role: .destructive) {
                KeychainManager.shared.clear()
                AuthenticationService.shared.status = .unauthenticated
            }
            Button("Выйти и удалить", role: .destructive) {
                viewModel.isExitDialogPresented = false
                viewModel.isRemoveAccountPresented = true
            }
            Button("Нет, вернуться назад", role: .cancel, action: {})
        }
        .confirmationDialog(
            "Удаление аккаунта",
            isPresented: $viewModel.isRemoveAccountPresented,
            titleVisibility: .visible
        ) {
            Button("Да, удалить", role: .destructive) {
                viewModel.removeAccount()
            }
            Button("Нет, вернуться назад", role: .cancel, action: {})
        }
        .font(.subheadline)
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 50)
        .foregroundStyle(themeManager.colors.textNeutral3)
        .background(themeManager.colors.bgNeutral3)
        .clipShape(.rect(cornerRadius: 24))
        
    }
    
    private func changeTheme(to theme: ColorScheme) {
        guard appearance != theme else { return }
        appearance = theme
        switch theme {
        case .dark:
            themeManager.setTheme(.dark)
        case .light:
            themeManager.setTheme(.light)
        }
    }
    
}
struct PhotoPickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Разрешаем только изображения
        config.selectionLimit = 1 // Можно выбрать 1 фото
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPickerView
        
        init(_ parent: PhotoPickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.selectedImage = image as? UIImage
                    }
                }
            }
        }
    }
}
