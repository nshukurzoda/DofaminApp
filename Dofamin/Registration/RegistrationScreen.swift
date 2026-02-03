//
//  RegistrationScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 30/12/24.
//

import SwiftUI

struct RegistrationScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    @StateObject var viewModel: RegistrationViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 42) {
                ZStack(alignment: .topTrailing) {
                    Image(.loginEllipse)
                        .resizable()
                    VStack {
                        Image(.logo)
                            .padding(geometry.safeAreaInsets.top)
                        Image(.registration)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: geometry.size.height * 0.4 + 30)
                VStack(alignment: .center, spacing: 16) {
                    Text(stringsManager.strings.registrationGreeting)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(themeManager.colors.textNeutral2)
                      
                    
                    Text(stringsManager.strings.registrationDescription)
                        .font(.headline)
                        .foregroundColor(themeManager.colors.textDisabled)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 16)
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button(action: {
                        viewModel.route(to: .enterInAccount)
                    }) {
                        Text(stringsManager.strings.registrationEnterButton)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(themeManager.colors.bgBrand1)
                            .foregroundColor(themeManager.colors.textOnBrand)
                            .cornerRadius(24)
                    }
                    
                    Button(action: {
                        viewModel.route(to: .creatingAccount)
                    }) {
                        Text(stringsManager.strings.registrationButton)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(themeManager.colors.bgDisabled)
                            .foregroundStyle(themeManager.colors.textNeutral2)
                            .cornerRadius(24)
                    }
                    Button("При входе вы принимаете условиями использования") {
                        guard let url = URL(string: "http://147.93.56.106:3000/docs/delivery.html") else { return }
                        UIApplication.shared.open(url)
                    }
                    .font(.footnote)
                    .foregroundStyle(themeManager.colors.textBrand1)
                }
                .padding(.horizontal, 24)
            }
            .ignoresSafeArea(edges: .top)
           
        }
        .background(themeManager.colors.bgNeutral1)
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen(viewModel: RegistrationViewModel())
            .environmentObject(ThemeManager(theme: .dark))
            .environmentObject(StringsManager(language: .ru))
    }
}
