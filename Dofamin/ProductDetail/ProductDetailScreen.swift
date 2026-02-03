//
//  ProductDetailScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 11/12/24.
//

import SwiftUI
import Kingfisher

struct ProductDetailScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    makeProduct2(product: viewModel.product, size: geometry.size)
                    if viewModel.product.isAvailable && KeychainManager.shared.isIdentified {
                        footerView
                            .padding(.vertical)
                    }
                }
            }
        })
        .background(themeManager.colors.bgNeutral1)
        .loader($viewModel.isLoading)
        .onAppear {
            viewModel.getProduct()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.product.name)
    }
    
    @ViewBuilder
    private func makeProduct2(
        product: ProductDetailModel.Product,
        size: CGSize
    ) -> some View {
        VStack(spacing: 0) {
            TabView(content: {
                ForEach(product.imageUrls, id: \.hashValue) { url in
                    KFImage(url)
                        .placeholder({ _ in
                            ProgressView()
                        })
                        .resizable()
                        .frame(height: size.height * 0.5)
                }
            })
            .tabViewStyle(.page)
            .frame(height: size.height * 0.5)
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    //                    Text("Напитки")
                    //                        .font(.subheadline)
                    //                        .foregroundStyle(themeManager.colors.textNeutral4)
                    //                        .padding(.vertical, 4)
                    //                        .padding(.horizontal, 16)
                    //                        .background(themeManager.colors.bgDisabled)
                    //                        .clipShape(.rect(cornerRadius: 24))
                    Spacer()
                    if product.isAvailable {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(themeManager.colors.textSuccess1)
                        Text(String(format: "В наличии: %d", product.quantity))
                            .foregroundStyle(themeManager.colors.textSuccess1)
                    }
                    else {
                        Text("Нет в наличии")
                            .foregroundStyle(themeManager.colors.textNeutral4)
                    }
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text(product.name)
                        .foregroundStyle(themeManager.colors.textNeutral2)
                        .font(.system(size: 24, weight: .semibold))
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(String(format: "%.2f TJS", product.price * Double(viewModel.count)))
                        .foregroundStyle(themeManager.colors.textBrand1)
                        .font(.title3)
                    if viewModel.product.isAvailable && KeychainManager.shared.isIdentified {
                        Stepper(String(format: "Количество: %d", viewModel.count), value: $viewModel.count, in: 1...viewModel.product.quantity)
                            .foregroundStyle(themeManager.colors.textNeutral2)
                            .accentColor(themeManager.colors.textNeutral2)
                            .frame(height: 25)
                    }
                }
                Divider()
                VStack(alignment: .leading, spacing: 16) {
                    Text("Описание:")
                        .foregroundStyle(themeManager.colors.textNeutral2)
                        .font(.headline)
                    Text(product.description)
                        .foregroundStyle(themeManager.colors.textNeutral4)
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
            .background(themeManager.colors.bgNeutral1)
        }
    }
    
    
    private var footerView: some View {
        Button(action: {
            if viewModel.isCountChanged {
                viewModel.updateCart()
            }
            else if viewModel.isAddedToCart {
                viewModel.deleteFromCart()
            }
            else {
                viewModel.addToCart()
            }
        }) {
            Group {
                if viewModel.isLoadingToCart {
                    ProgressView()
                        .tint(themeManager.colors.textOnBrand)
                }
                else {
                    Text(viewModel.buttonTitle)
                        .font(.headline)
                        .foregroundStyle(themeManager.colors.textOnBrand)
                }
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
        }
        .disabled(viewModel.isLoadingToCart)
        .background(themeManager.colors.bgBrand1)
        .clipShape(.rect(cornerRadius: 24))
        .padding(.horizontal)
    }
}
