//
//  ProductScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/12/24.
//
import SwiftUI
import Kingfisher

struct ProductScreen: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var viewModel: ProductViewModel
    @State private var searchText: String = ""
    
    private let adaptiveProduct = [
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
        GridItem(.flexible(minimum: 150, maximum: .infinity))
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 16) {
                makeSearchField()
                    .padding(.horizontal)
                makeCategories()
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    LazyVGrid(columns: adaptiveProduct, spacing: 24) {
                        ForEach(viewModel.products) { product in
                            Button {
                                viewModel.route(to: .product(product))
                            } label: {
                                makeProduct(product: product)
                            }
                            .task {
                                guard viewModel.isLast(product: product) else { return }
                                viewModel.getNextProducts()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 24)
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                            .tint(themeManager.colors.textNeutral4)
                    }
                }
                .padding(.vertical, 12)
            }
        }
        .navigationTitle("Продукты")
        .background(themeManager.colors.bgNeutral1)
        .refreshable {
            viewModel.getProducts(filter: viewModel.filter)
        }
        .onAppear {
            viewModel.getSubCategories()
        }
        .onLoad {
            viewModel.getProducts(filter: viewModel.filter)
        }
        .sheet(isPresented: $viewModel.isFilterPresented, content: {
            filterView
        })
        
    }
    
    @ViewBuilder
    private func makeCategories() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.subCategories) { subCategory in
                    Button(action: {
                        viewModel.filter.subCategory = subCategory == viewModel.filter.subCategory ? nil : subCategory
                    }, label: {
                        Text(subCategory.name)
                            .foregroundStyle(viewModel.filter.subCategory == subCategory ? themeManager.colors.textOnBrand : themeManager.colors.textNeutral4)
                            .padding(.horizontal, 12)
                    })
                    .frame(height: 32)
                    .background(viewModel.filter.subCategory == subCategory ? themeManager.colors.bgBrand1 : themeManager.colors.bgDisabled)
                    .clipShape(.rect(cornerRadius: 16))
                }
            }
            .padding(.horizontal, 12)
        }
        .frame(height: 32)
    }
    
    @ViewBuilder
    private func makeSearchField() -> some View {
        HStack(spacing: 14) {
            Image(systemName: "magnifyingglass")
            TextField("Поиск по имени", text: $searchText) {
                viewModel.filter.searchText = searchText
            }
            Button(action: {
                viewModel.isFilterPresented = true
            }, label: {
                Image(systemName: "slider.horizontal.3")
                    .frame(square: 20)
                    .foregroundStyle(themeManager.colors.textNeutral2)
            })
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(themeManager.colors.bgNeutral2)
        .clipShape(.rect(cornerRadius: 41))
    }
    
    @ViewBuilder
    private func makeProduct(product: ProductModel.Product) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(product.image)
                .placeholder({ _ in
                    ProgressView()
                })
                .resizable()
                .frame(height: 160)
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.name)
                        .foregroundStyle(themeManager.colors.textNeutral2)
                        .lineLimit(1)
                    Text(product.description)
                        .foregroundStyle(themeManager.colors.textNeutral4)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                HStack {
                    Text(String(format: "%.2f TJS", product.price))
                        .foregroundColor(themeManager.colors.textBrand1)
                        .fontWeight(.bold)
                    Spacer()
                    if product.isAvailable && KeychainManager.shared.isIdentified {
                        Button(action: {
                            if product.isAddedToCart {
                                viewModel.deleteFromCart(id: product.id)
                            }
                            else {
                                viewModel.addToCart(id: product.id)
                            }
                        }, label: {
                            Image(systemName: product.isAddedToCart ? "cart.fill" : "cart")
                                .frame(square: 36)
                                .background(themeManager.colors.bgBrand3)
                                .foregroundStyle(themeManager.colors.textBrand1)
                                .clipShape(.rect(cornerRadius: 10))
                        })
                    }
                }
            }
            .padding(8)
        }
        .background(themeManager.colors.bgNeutral1)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
    
    var filterView: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            HStack(spacing: 10) {
                Button(action: {
                    viewModel.isFilterPresented = false
                }, label: {
                    Image(systemName: "xmark")
                        .frame(square: 10)
                        .foregroundStyle(themeManager.colors.textNeutral2)
                })
                .frame(square: 24)
                Text("Сортировка")
                    .font(.title3.bold())
                    .foregroundStyle(themeManager.colors.textNeutral2)
            }
            .padding()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(ProductModel.ProductType.allCases, id: \.self) { type in
                        Button(action: {
                            viewModel.isFilterPresented = false
                            viewModel.filter.productType = type
                        }, label: {
                            HStack {
                                Text(type.title)
                                    .foregroundStyle(themeManager.colors.textNeutral2)
                                Spacer()
                                Image(
                                    systemName: viewModel.filter.productType == type
                                    ? "checkmark.circle.fill"
                                    : "circle"
                                )
                                .foregroundStyle(
                                    viewModel.filter.productType == type
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
        })
    }
}
