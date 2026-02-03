//
//  MyOrdersScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 20/12/24.
//
import SwiftUI
import Kingfisher

struct MyOrdersScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var stringsManager: StringsManager
    @StateObject var viewModel = MyOrdersViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(viewModel.orders.count) заказов")
                .foregroundStyle(themeManager.colors.textNeutral4)
                .padding(.horizontal)
            Picker("", selection: $viewModel.selectedOrderStatus) {
                ForEach(MyOrdersModel.Status.allCases, id: \.self) { type in
                    Text(type.title)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .clipShape(.rect(cornerRadius: 48))
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.orders) { order in
                        Button(action: {
                            viewModel.route(to: .orderDetail(order))
                        }, label: {
                            makeOrderView(for: order)
                        })
                    }
                }
                .padding()
            }
        }
        .loader($viewModel.isLoading)
        .navigationTitle("Мои заказы")
        .onLoad {
            viewModel.getOrders()
        }
        .background(themeManager.colors.bgNeutral1)
    }
    
    @ViewBuilder
    func makeOrderView(for order: MyOrdersModel.Order) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Количество товаров: \(order.products.count)")
                    .font(.subheadline)
                    .foregroundStyle(themeManager.colors.textNeutral2)
                Spacer()
                Text("Заказ №\(order.id)")
                    .font(.headline)
                    .foregroundStyle(themeManager.colors.textNeutral2)
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(order.products, id: \.hashValue) { url in
                        KFImage(url)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 16))
                    }
                }
                .padding(.horizontal)
            }
            HStack(spacing: 8) {
                Text(order.status.title)
                    .font(.subheadline)
                    .foregroundStyle(themeManager.colors.textNeutral4)
                Spacer()
                Text(order.date.formatted(.dateTime.day().month().year()))
                    .font(.subheadline)
                    .foregroundStyle(themeManager.colors.textNeutral4)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(themeManager.colors.bgNeutral1)
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: themeManager.colors.textNeutral4.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        MyOrdersScreen(viewModel: MyOrdersViewModel())
            .environmentObject(ThemeManager(theme: .dark))
            .environmentObject(StringsManager(language: .ru))
    }
}
