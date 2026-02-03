//
//  CatalogScreen.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/12/24.
//

import SwiftUI
import Kingfisher

struct CatalogScreen: View {
    @StateObject var viewModel: CatalogViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    
    private let adaptiveColumn = [
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
        GridItem(.flexible(minimum: 150, maximum: .infinity))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: adaptiveColumn, spacing: 24) {
                ForEach(viewModel.catalogs) { catalog in
                    Button(action: {
                        viewModel.route(to: .product(catalog))
                    }, label: {
                        makeCatalogView(catalog: catalog)
                    })
                }
            }
            .padding()
        }
        .background(themeManager.colors.bgNeutral1)
        .navigationTitle("Каталог")
        .loader($viewModel.isLoading)
        .onLoad {
            viewModel.getCatalogs()
        }
        .refreshable {
            viewModel.getCatalogs()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !KeychainManager.shared.isAuthenticated {
                    Text("Войти")
                        .foregroundStyle(themeManager.colors.textOnBrand)
                        .frame(width: 80, height: 32, alignment: .center)
                        .background(themeManager.colors.bgBrand1)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            AuthenticationService.shared.status = .unauthenticated
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private func makeCatalogView(catalog: CatalogModel.Catalog) -> some View {
        
        KFImage(catalog.imageUrl)
            .contentConfigure { image in
                VStack(spacing: 8) {
                    Group {
                        Text(catalog.name)
                        Text(String(format: "%d товаров", catalog.productCount))
                    }
                    .foregroundStyle(themeManager.colors.textNeutralStaticInverted1)
                    .font(.body.bold())
                }
                .shadow(color: Color.black.opacity(0.8), radius: 5, x: 3, y: 3)
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .frame(square: 164, alignment: .top)
                .background(
                    image
                        .resizable()
                )
            }
            .placeholder { _ in
                ProgressView()
                    .tint(themeManager.colors.textNeutral4)
                    .frame(square: 164, alignment: .center)
                
            }
            .background(themeManager.colors.bgNeutral2)
            .clipShape(.rect(cornerRadius: 24))
    }
}

#Preview {
    NavigationView(content: {
        CatalogScreen(viewModel: CatalogViewModel())
            .environmentObject(ThemeManager(theme: .light))
    })
}

