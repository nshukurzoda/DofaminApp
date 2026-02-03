//
//  EnterInAccountScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 02/01/25.
//
import SwiftUI

struct EnterInAccountScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    @StateObject var viewModel: EnterInAccountViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
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
                
                VStack(alignment: .center, spacing: 12) {
                    TextField(
                        "",
                        text: $viewModel.data.number,
                        prompt: Text(stringsManager.strings.enterInNumberPlaceHolder).foregroundColor(themeManager.colors.textNeutral4)
                    )
                    .onChange(of: viewModel.data.number) { newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count > 9 {
                            viewModel.data.number = String(filtered.prefix(9))
                        } else {
                            viewModel.data.number = filtered
                        }
                    }
                    .textContentType(.telephoneNumber)
                    .padding()
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .background(themeManager.colors.bgDisabled)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
                    SecureField(
                        "",
                        text: $viewModel.data.password,
                        prompt: Text(stringsManager.strings.enterInPasswordPlaceHolder).foregroundColor(themeManager.colors.textNeutral4)
                    )
                    .textContentType(.password)
                    .padding()
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .background(themeManager.colors.bgDisabled)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
                }
                .padding(.horizontal, 12)
                
                Spacer()
                Button(action: {
                    viewModel.login()
                }) {
                    if viewModel.loading {
                        ProgressView()
                    }
                    else {
                        Text("Войти")
                            .fontWeight(.bold)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .tint(
                    viewModel.data.isValid
                    ? themeManager.colors.textOnBrand
                    : themeManager.colors.textDisabled
                )
                .foregroundStyle(
                    viewModel.data.isValid
                    ? themeManager.colors.textOnBrand
                    : themeManager.colors.textDisabled
                )
                .background(
                    viewModel.data.isValid
                    ? themeManager.colors.bgBrand1
                    : themeManager.colors.bgDisabled
                )
                .disabled(!viewModel.data.isValid)
                .clipShape(.rect(cornerRadius: 24))
                .padding(.horizontal, 12)
                .padding(.bottom)
            }
            
            .ignoresSafeArea(edges: .top)
            .background(themeManager.colors.bgNeutral1)
            .disabled(viewModel.loading)
            .alert(
                viewModel.error.message ?? stringsManager.strings.creatingAccountUnkownError,
                isPresented: $viewModel.error.isPresented
            ) {} 
        }
    }
}
#Preview {
    NavigationView {
        EnterInAccountScreen(viewModel: EnterInAccountViewModel())
            .environmentObject(ThemeManager(theme: .dark))
            .environmentObject(StringsManager(language: .ru))
    }
}
