//
//  MyAddressesScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 25/12/24.
//

import SwiftUI

struct MyAddressesScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    @StateObject var viewModel: MyAddressesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.addresses, id: \.id) { address in
                    Button(action: {
                        viewModel.route(to: .addAddress(address))
                    }, label: {
                        Text(address.details)
                            .padding()
                            .foregroundStyle(themeManager.colors.textNeutral2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(themeManager.colors.bgDisabled)
                            .clipShape(.rect(cornerRadius: 48))
                    })
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(stringsManager.strings.myAddressTittle)
        .background(themeManager.colors.bgNeutral1)
        .loader($viewModel.isLoading)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Добавить") {
                    viewModel.route(to: .addAddress(nil))
                }
                .foregroundStyle(themeManager.colors.textBrand1)
            }
        }
        .onAppear(perform: {
            viewModel.getAddresses()
        })
    }
}

#Preview {
    NavigationView {
        MyAddressesScreen(viewModel: MyAddressesViewModel())
            .environmentObject(ThemeManager(theme: .light))
            .environmentObject(StringsManager(language: .ru))
    }
}
 
