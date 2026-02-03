//
//  OrderAcceptScreen.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 11/02/25.
//

import SwiftUI

struct OrderAcceptScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var router: OrderConfirmationCoordinator.Router
    
    var body: some View {
        VStack(spacing: 12) {
            Image(.orderAccept)
                .padding(.bottom, 30)
            Text("Ваш заказ принят!")
                .foregroundStyle(themeManager.colors.textNeutral2)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("Ваш заказ оформлен и находится в процессе обработки, наш оператор свяжется с вами для уточнения деталей")
                .foregroundStyle(themeManager.colors.textNeutral4)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 50)
        .frame(maxHeight: .infinity)
        .overlay(alignment: .bottom, content: {
            Button(action: {
                router.dismissCoordinator()
            }) {
                Text("Вернуться на главную")
                    .foregroundStyle(themeManager.colors.textOnBrand)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
            .background(themeManager.colors.bgBrand1)
            .clipShape(.rect(cornerRadius: 24))
        })
        .padding()
        .background(themeManager.colors.bgNeutral1)
    }
}

#Preview {
    OrderAcceptScreen()
        .environmentObject(ThemeManager(theme: .light))
}
