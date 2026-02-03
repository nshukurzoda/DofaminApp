//
//  MyProfileScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 14/12/24.
//

import SwiftUI
struct MyProfileScreen: View {
    @StateObject var viewModel: MyProfileViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField(
                "",
                text: $viewModel.profile.name,
                prompt: Text(stringsManager.strings.myProfileNamePlaceholder).foregroundColor(themeManager.colors.textNeutral4)
            )
            .padding()
            .foregroundStyle(themeManager.colors.textNeutral2)
            .background(themeManager.colors.bgDisabled)
            .clipShape(.rect(cornerRadius: 48))
            TextField(
                "",
                text: $viewModel.profile.number,
                prompt: Text(stringsManager.strings.myProfileNumberPlaceholder).foregroundColor(themeManager.colors.textNeutral4)
            )
            .keyboardType(.numberPad)
            .padding()
            .foregroundStyle(themeManager.colors.textNeutral2)
            .background(themeManager.colors.bgDisabled)
            .clipShape(.rect(cornerRadius: 48))
            Spacer()
            Button(action: {
                viewModel.update()
            }) {
                Group {
                    if viewModel.profile.isLoading {
                        ProgressView()
                            .tint(themeManager.colors.textOnBrand)
                    }
                    else {
                        Text("Сохранить")
                            .foregroundStyle(
                                viewModel.profile.isAvailable ? themeManager.colors.textOnBrand : themeManager.colors.textDisabled
                            )
                            .font(.title3)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
            .disabled(!viewModel.profile.isAvailable)
            .background(
                viewModel.profile.isAvailable ? themeManager.colors.bgBrand1 : themeManager.colors.bgDisabled
            )
            .clipShape(.rect(cornerRadius: 24))
            .padding(.vertical)
        }
        .padding(.horizontal)
        .navigationTitle(stringsManager.strings.myProfileTitle)
        .background(themeManager.colors.bgNeutral1)
    }
    
}

