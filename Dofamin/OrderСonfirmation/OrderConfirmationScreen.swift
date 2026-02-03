//
//  OrderConfirmationScreen.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 06/02/25.
//

import SwiftUI

struct OrderConfirmationScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel: OrderConfirmationViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                Divider()
                addressView
                Divider()
                priceView
                Divider()
                noteView
                Button("Оформляя заказ, вы соглашаетесь с нашими Условиями и Положениями.") {
                    guard let url = URL(string: "http://147.93.56.106:3000/docs/delivery.html") else { return }
                    UIApplication.shared.open(url)
                }
                .foregroundStyle(themeManager.colors.textNeutral4)
                Button(action: {
                    viewModel.order()
                }) {
                    Group {
                        if viewModel.isOrderLoading {
                            ProgressView()
                                .tint(themeManager.colors.textOnBrand)
                        }
                        else {
                            Text("Подтвердить")
                                .foregroundStyle(
                                    viewModel.isAvailable ? themeManager.colors.textOnBrand : themeManager.colors.textDisabled
                                )
                                .font(.title3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                }
                .disabled(!viewModel.isAvailable)
                .background(
                    viewModel.isAvailable ? themeManager.colors.bgBrand1 : themeManager.colors.bgDisabled
                )
                .clipShape(.rect(cornerRadius: 24))
            }
            .padding(.horizontal)
        }
        .disabled(viewModel.isOrderLoading)
        .background(themeManager.colors.bgNeutral1)
        .navigationTitle("Подтверждение")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewModel.route(to: .previous)
                }, label: {
                    Image(systemName: "xmark")
                        .frame(square: 10)
                        .foregroundStyle(Palette.brand6)
                })
                .frame(square: 24)
            }
        }
        .background(themeManager.colors.bgNeutral1)
    }
    
    var addressView: some View {
        Button(action: {
            viewModel.route(to: .deliveryMethod)
        }, label: {
            HStack {
                Text("Адрес")
                    .foregroundStyle(themeManager.colors.textNeutral4)
                Spacer()
                Text(viewModel.selectedAddress?.details ?? "Добавить")
                    .lineLimit(1)
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .font(.callout)
                Image(systemName: "chevron.right")
                    .foregroundStyle(Palette.brand6)
            }
        })
    }
    
    var priceView: some View {
        HStack {
            Text("Итого")
                .foregroundStyle(themeManager.colors.textNeutral4)
            Spacer()
            Text(String(format: "%.2f TJS", viewModel.amount))
                .foregroundStyle(themeManager.colors.textNeutral2)
        }
    }
    
    var noteView: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $viewModel.note)
                .foregroundStyle(themeManager.colors.textNeutral2)
                .transparentScrolling()
            
            if viewModel.note.isEmpty {
                Text("Пожелания к заказу")
                    .foregroundStyle(themeManager.colors.textNeutral4)
                    .padding(.leading, 5)
                    .padding(.top, 7)
            }
        }
        .padding()
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(themeManager.colors.bgNeutral2)
        .clipShape(.rect(cornerRadius: 12))
    }
}

public extension View {
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}
