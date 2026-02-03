//
//  AddAddressScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 26/12/24.
//

import SwiftUI

struct AddAddressScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    @StateObject var viewModel: AddAddressViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                makeTextField(
                    stringsManager.strings.addAddressCityPlaceholder,
                    text: $viewModel.address.city
                )
                makeTextField(
                    "Н. Махсум, 18/20, 25",
                    text: $viewModel.address.details
                )
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .padding()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .background(themeManager.colors.bgNeutral2)
                        .foregroundStyle(themeManager.colors.bgNeutral2)
                        .clipShape(.rect(cornerRadius: 12))
                        
                    
                    TextEditor(text: $viewModel.address.landmark)
                        .foregroundStyle(themeManager.colors.textNeutral2)
                        .clipShape(.rect(cornerRadius: 12))
                    
                    if viewModel.address.landmark.isEmpty {
                        Text("Пожелания к заказу")
                            .foregroundStyle(themeManager.colors.textNeutral4)
                            .padding(.leading, 5)
                            .padding(.top, 7)
                            .onAppear(perform: {
                                print("eftm", themeManager.colors.textNeutral4, themeManager.colors.bgNeutral2)
                            })
                    }
                }
                Button(action: {
                    print("eftm")
                    if viewModel.isAddressChanged {
                        viewModel.update()
                    }
                    else if viewModel.address.isAdded {
                        viewModel.delete()
                    }
                    else {
                        viewModel.add()
                    }
                }) {
                    Group {
                        if viewModel.address.isLoading {
                            ProgressView()
                                .tint(themeManager.colors.textOnBrand)
                        }
                        else {
                            Text(viewModel.buttonTitle)
                                .foregroundStyle(
                                    viewModel.address.isAvailable ? themeManager.colors.textOnBrand : themeManager.colors.textDisabled
                                )
                                .font(.title3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                }
                .disabled(!viewModel.address.isAvailable)
                .background(
                    viewModel.address.isAvailable ? themeManager.colors.bgBrand1 : themeManager.colors.bgDisabled
                )
                .clipShape(.rect(cornerRadius: 24))
                .padding(.vertical)
            }
            .padding(.horizontal, 12)
        }
        .disabled(viewModel.address.isLoading)
        .navigationTitle("Адрес")
        .background(themeManager.colors.bgNeutral1)
    }
    
    @ViewBuilder
    func makeTextField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField("", text: text, prompt: Text(placeholder).foregroundColor(themeManager.colors.textNeutral4))
            .padding()
            .foregroundStyle(themeManager.colors.textNeutral2)
            .background(
                RoundedRectangle(cornerRadius: 48)
                    .fill(Color.gray.opacity(0.1))
            )
            .frame(height: 58)
    }
}
#Preview {
    NavigationView {
        AddAddressScreen(viewModel: AddAddressViewModel())
            .environmentObject(ThemeManager(theme: .light))
            .environmentObject(StringsManager(language: .ru))
    }
}
