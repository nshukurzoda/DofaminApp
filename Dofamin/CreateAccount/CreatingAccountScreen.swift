//
//  CreatingAccountScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 02/01/25.
//

import SwiftUI

struct CreatingAccountScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    @StateObject var viewModel: CreatingAccountViewModel
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image(.loginEllipse)
                        .resizable()
                    Image(.loginPeople)
                        .resizable()
                        .scaledToFit()
                        .padding(.top, geometry.safeAreaInsets.top)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(height: geometry.size.height * 0.5 + 30)
                VStack(alignment:.center, spacing: 14) {
                    TextField(
                        "",
                        text: $viewModel.account.name,
                        prompt: Text(stringsManager.strings.creatingAccountNamePlaceholder).foregroundColor(themeManager.colors.textNeutral4)
                    )
                    .padding()
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .background(themeManager.colors.bgDisabled)
                    .clipShape(.rect(cornerRadius: 48))
                    TextField(
                        "",
                        text: $viewModel.account.phoneNumber,
                        prompt: Text(stringsManager.strings.creatingAccountPhonePlaceholder).foregroundColor(themeManager.colors.textNeutral4)
                    )
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.account.phoneNumber) { newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count > 9 {
                            viewModel.account.phoneNumber = String(filtered.prefix(9))
                        } else {
                            viewModel.account.phoneNumber = filtered
                        }
                    }
                    .padding()
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .background(themeManager.colors.bgDisabled)
                    .clipShape(.rect(cornerRadius: 48))
                    SecureField(
                        "",
                        text: $viewModel.account.password,
                        prompt: Text(stringsManager.strings.creatingAccountPasswordPlaceholder).foregroundColor(themeManager.colors.textNeutral4)
                    )
                    .textContentType(.password)
                    .padding()
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .background(themeManager.colors.bgDisabled)
                    .clipShape(.rect(cornerRadius: 48))
                }
                .padding(.horizontal, 12)
                .padding(.top)
                Spacer()
                Button(action: {
                    viewModel.create()
                }) {
                    if viewModel.loading {
                        ProgressView()
                    }
                    else {
                        Text(stringsManager.strings.registrationButton)
                            .fontWeight(.bold)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .tint(
                    viewModel.account.isValid
                    ? themeManager.colors.textOnBrand
                    : themeManager.colors.textDisabled
                )
                .foregroundStyle(
                    viewModel.account.isValid
                    ? themeManager.colors.textOnBrand
                    : themeManager.colors.textDisabled
                )
                .background(
                    viewModel.account.isValid
                    ? themeManager.colors.bgBrand1
                    : themeManager.colors.bgDisabled
                )
                .disabled(!viewModel.account.isValid)
                .clipShape(.rect(cornerRadius: 24))
                .padding(.horizontal, 12)
                .padding(.bottom)
            }
            .ignoresSafeArea(edges: .top)
            .background(themeManager.colors.bgNeutral1)
        })
        .disabled(viewModel.loading)
        .onAppear(perform: {
            viewModel.setup(strings: stringsManager.strings)
        })
        .alert(
            viewModel.error.message,
            isPresented: $viewModel.error.isPresented
        ) {}
    }
}

#Preview {
    NavigationView(content: {
        CreatingAccountScreen(viewModel: CreatingAccountViewModel())
            .environmentObject(ThemeManager(theme: .light))
            .environmentObject(StringsManager(language: .ru))
    })
}
