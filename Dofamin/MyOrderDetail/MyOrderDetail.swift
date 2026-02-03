//
//  OrderDetail.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 21/12/24.
//

import SwiftUI
import Kingfisher

struct OrderDetailScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var viewModel: OrderDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12 ){
            HStack{
                Text("Количество товаров: \(viewModel.orders.count)")
                    .foregroundStyle(themeManager.colors.textNeutral4)
                Spacer()
                Text(viewModel.orderData.status.title)
                    .foregroundStyle(
                        viewModel.orderData.status.textColor(for: themeManager.colors)
                    )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        viewModel.orderData.status.backgroundColor(for: themeManager.colors)
                    )
                    .clipShape(.rect(cornerRadius: 12))
            }
            
            .padding(.horizontal)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach (viewModel.orders) { order in
                        makeOrderDetail(for: order)
                    }
                    makeOrderDetailData(for: viewModel.orderData)
                }
                .padding()
            }
        }
        .navigationTitle("Заказ №\(viewModel.orderData.id)")
        .background(themeManager.colors.bgNeutral1)
    }
    
    
    
    @ViewBuilder
    func makeOrderDetail(for order: OrderDetailModel.Order) -> some View {
        HStack(alignment: .top, spacing: 8) {
            KFImage(order.product.image)
                .placeholder({ _ in
                    ProgressView()
                })
                .resizable()
                .clipShape(.rect(cornerRadius: 16))
                .frame(square: 100)
            VStack(alignment: .leading, spacing: 6) {
                Text(order.product.subCategoryName ?? "")
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(themeManager.colors.textNeutral4)
                    .font(.subheadline)
                    .lineLimit(2)
                Text(order.product.name)
                    .font(.headline)
                    .foregroundStyle(themeManager.colors.textNeutral2)
                    .lineLimit(1)
                Spacer()
                HStack {
                    Text(String(format: "%.2f сом.", order.product.price))
                        .foregroundStyle(themeManager.colors.textBrand1)
                        .font(.body)
                        .lineLimit(1)
                    Spacer()
                    Text(String(format: "Количество: %d", order.quantity))
                        .font(.footnote)
                        .lineLimit(1)
                        .foregroundStyle(themeManager.colors.textNeutral2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4)
            //            Button(action: {
            //                viewModel.selectedorderOption = order
            //            }, label: {
            //                Image(systemName: "ellipsis")
            //                    .foregroundStyle(themeManager.colors.textNeutral4)
            //                    .frame(square: 20)
            //            })
            
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(themeManager.colors.bgNeutral1)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: themeManager.colors.textNeutral4.opacity(0.3), radius: 4, x: 0, y: 2
        )
        
    }
    
    @ViewBuilder
    func makeOrderDetailData(for order: OrderDetailModel.OrderData) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Информация о заказе:")
                .font(.title3)
                .foregroundStyle(themeManager.colors.textNeutral2)
            VStack(spacing: 16) {
                Group {
                    HStack {
                        Text("Адрес")
                            .foregroundStyle(themeManager.colors.textNeutral4)
                        Spacer()
                        Text(order.address)
                            .foregroundStyle(themeManager.colors.textNeutral2)
                    }
                    Divider()
                    HStack {
                        Text("Итого")
                            .foregroundStyle(themeManager.colors.textNeutral4)
                        Spacer()
                        Text(String(format: "%.2f TJS", order.price))
                            .foregroundStyle(themeManager.colors.textNeutral2)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .background(themeManager.colors.bgNeutral1)
            .clipShape(.rect(cornerRadius: 16))
            .shadow(
                color: themeManager.colors.textNeutral4.opacity(0.3),
                radius: 4, x: 0, y: 2
            )
            
        }
        
        
    }
    
}
