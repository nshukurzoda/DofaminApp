//
//  CartScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 26/12/24.
//

import SwiftUI
import Kingfisher

struct CartScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    @StateObject var viewModel: CartViewModel
    
    var body: some View {
        Group {
            if viewModel.cartItems.isEmpty {
                emptyView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.cartItems) { cart in
                            Button(action: {
                                viewModel.route(to: .productDetail(cart))
                            }, label: {
                                makeOrderDetail(for: cart)
                            })
                        }
                    }
                    .padding()
                }
            }
        }
        .background(themeManager.colors.bgNeutral1)
        .navigationTitle("Корзина")
        .loader($viewModel.isLoading)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Оформить заявку") {
                    viewModel.route(to: .orderConfirmation)
                }
                .foregroundStyle(
                    viewModel.cartItems.isEmpty
                    ? themeManager.colors.textDisabled
                    : themeManager.colors.textBrand1
                )
                .disabled(viewModel.cartItems.isEmpty)
            }
        }
        .onAppear(perform: {
            viewModel.getCart()
        })
    }
    
    @ViewBuilder
    var emptyView: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(.bagCross)
                .frame(square: 64)
                .frame(square: 88)
                .background(themeManager.colors.bgBrand3)
                .clipShape(.rect(cornerRadius: 24))
            Text("Пока ничего нет")
                .foregroundStyle(themeManager.colors.textNeutral2)
                .font(.headline)
                .padding(.top, 12)
            Text("Загляните в наш каталог — там вы найдёте всё, что нужно!")
                .foregroundStyle(themeManager.colors.textNeutral4)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    func makeOrderDetail(for cart: CartModel.Cart) -> some View {
        HStack(alignment: .top, spacing: 8) {
            KFImage(cart.product.image)
                .placeholder({ _ in
                    ProgressView()
                })
                .resizable()
                .clipShape(.rect(cornerRadius: 16))
                .frame(square: 100)
            VStack(alignment: .leading, spacing: 6) {
                Text(cart.product.subCategoryName ?? "")
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(themeManager.colors.textNeutral4)
                    .font(.subheadline)
                    .lineLimit(2)
                Text(cart.product.name)
                    .font(.headline)
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .lineLimit(1)
                Spacer()
                HStack {
                    Text(String(format: "%.2f сом.", cart.product.price))
                        .foregroundStyle(themeManager.colors.textBrand1)
                        .font(.body)
                        .lineLimit(1)
                    Spacer()
                    HStack {
                        Button {
                            viewModel.removeCount(for: cart)
                        } label: {
                            Image(.minusCount)
                                .frame(square: 20)
                        }
                        Text(cart.quantity.description)
                            .foregroundStyle(themeManager.colors.textNeutral2)
                        Button {
                            viewModel.addCount(for: cart)
                        } label: {
                            Image(.addCount)
                                .frame(square: 20)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(themeManager.colors.bgNeutral2)
                    .clipShape(.rect(cornerRadius: 16))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(themeManager.colors.bgNeutral1)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: themeManager.colors.textNeutral4.opacity(0.3), radius: 4, x: 0, y: 2
        )
    }
    
}
#Preview {
    NavigationView{
        CartScreen(viewModel: CartViewModel())
            .environmentObject(ThemeManager(theme: .light))
            .environmentObject(StringsManager(language: .ru))
    }
}
