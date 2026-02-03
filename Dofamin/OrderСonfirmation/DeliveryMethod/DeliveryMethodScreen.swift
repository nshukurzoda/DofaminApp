//
//  DeliveryMethodScreen.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 08/02/25.
//

import SwiftUI

struct DeliveryMethodScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @StateObject var viewModel: DeliveryMethodViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(viewModel.addresses, id: \.id) { address in
                    Button(action: {
                        viewModel.selectedAddress = address
                    }, label: {
                        HStack {
                            Text(address.details)
                                .foregroundStyle(themeManager.colors.textNeutral2)
                            Spacer()
                            Image(
                                systemName: viewModel.selectedAddress == address
                                ? "checkmark.circle.fill"
                                : "circle"
                            )
                            .foregroundStyle(
                                viewModel.selectedAddress == address
                                ? themeManager.colors.textBrand1
                                : themeManager.colors.strNeutral1
                            )
                            .frame(square: 16)
                        }
                    })
                    Divider()
                }
            }
            .padding()
        }
        .onAppear(perform: {
            viewModel.getAddresses()
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Добавить") {
                    viewModel.route(to: .addAddress)
                }
                .foregroundStyle(themeManager.colors.textBrand1)
            }
        }
        .frame(maxWidth: .infinity)
        .background(themeManager.colors.bgNeutral1)
        .navigationTitle("Адреса")
        .tint(themeManager.colors.textBrand1)
        .loader($viewModel.isLoading)
    }
}

#Preview {
    DeliveryMethodScreen(viewModel: .init(addresses: [ .init(id: 0, landmark: "", city: "", details: "")], selectedAddress: nil))
        .environmentObject(ThemeManager(theme: .light))
}
