//
//  ThemeManager.swift
//  Tcell
//
//  Created by Boboev Saddam on 12/11/24.
//

import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    @Published var colors: DesignColors
    var theme: DesignColors.Theme
    init(theme: DesignColors.Theme = AppThemeViewModel().appearance == .dark ? .dark : .light) {
        self.theme = theme
        colors = DesignColors(theme: theme)
        setTheme(theme)
    }
    
    func setTheme(_ theme: DesignColors.Theme) {
        self.theme = theme
        colors = DesignColors(theme: theme)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(colors.bgNeutral2)
        UISegmentedControl.appearance().backgroundColor = UIColor(colors.bgNeutral1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(colors.textNeutral2)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(colors.textNeutral2)], for: .normal)
        UINavigationBar.appearance().tintColor = UIColor(colors.textNeutral2)
        UIBarButtonItem.appearance().tintColor = UIColor(Palette.brand6)
        let minusImage = UIImage(systemName: "minus")
        let plusImage = UIImage(systemName: "plus")
        UIStepper.appearance().setDecrementImage(minusImage?.withTintColor(UIColor(colors.textNeutral2)), for: .normal)
        UIStepper.appearance().setIncrementImage(plusImage?.withTintColor(UIColor(colors.textNeutral2)), for: .normal)
        print("ThemeManager", colors.textNeutral2)
    }
}

class StringsManager: ObservableObject {
    @Published var strings: Strings
    
    init(language: Language) {
        self.strings = Strings(language: language)
    }
}

struct Strings {
    let language: Language
    
    let myProfileNamePlaceholder: String
    let myProfileNumberPlaceholder: String
    let myProfileTitle: String
    let myProfilePasswordPlaceholder: String
    let myOrdersInWayTitle: String
    let myOrdersHistoryTitile: String
    let myAddressTittle: String
    let myAddressPlaceholder: String
    let addAddressCityPlaceholder: String
    var addAddressStreetPlaceholder: String
    let addAddressFlatPlaceholder: String
    let addAddressHousePlaceholder: String
    let addAddressNavigationTitle: String
    let registrationGreeting: String
    let registrationDescription: String
    let registrationEnterButton: String
    let registrationButton: String
    let enterInNumberPlaceHolder: String
    let enterInPasswordPlaceHolder: String
    let enterInButton: String
    let creatingAccountUnkownError: String
    let creatingAccountNamePlaceholder: String
    let creatingAccountPhonePlaceholder: String
    let creatingAccountPasswordPlaceholder: String
    let profileName: String
    let profileOrders: String
    let profileMyProfile:String
    let profileAddresses: String
    
    init(language: Language) {
        self.language = language
        let path = Bundle.main.path(forResource: language.code, ofType: "lproj")
        let bundle = Bundle(path: path!)!
        
        self.myProfileNamePlaceholder = NSLocalizedString(
            "my_profile_name_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.myProfileNumberPlaceholder = NSLocalizedString(
            "my_profile_number_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.myProfilePasswordPlaceholder = NSLocalizedString(
            "my_profile_password_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.myProfileTitle = NSLocalizedString(
            "my_profile_title",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.myOrdersInWayTitle = NSLocalizedString(
            "my_orders_in_way_title",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.myOrdersHistoryTitile = NSLocalizedString(
            "my_orders_history_title",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
            
        )
        self.myAddressTittle = NSLocalizedString(
            "my_address_title",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.myAddressPlaceholder = NSLocalizedString(
            "my_address_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.addAddressCityPlaceholder = NSLocalizedString(
            "add_address_city_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.addAddressStreetPlaceholder = NSLocalizedString(
            "add_address_street_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.addAddressFlatPlaceholder = NSLocalizedString(
            "add_address_flat_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.addAddressHousePlaceholder = NSLocalizedString(
            "add_address_house_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.addAddressNavigationTitle = NSLocalizedString(
            "add_address_navigation_title",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.registrationGreeting = NSLocalizedString(
            "registration_greeting",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.registrationDescription = NSLocalizedString(
            "registration_description",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.registrationEnterButton = NSLocalizedString(
            "registration_enter_button",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.registrationButton = NSLocalizedString(
            "registration_button",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.enterInNumberPlaceHolder = NSLocalizedString(
            "enter_in_number_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.enterInPasswordPlaceHolder = NSLocalizedString(
            "enter_in_password_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.enterInButton = NSLocalizedString(
            "enter_in_button",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.creatingAccountUnkownError = NSLocalizedString(
            "creating_account_unkown_error",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.creatingAccountNamePlaceholder = NSLocalizedString(
            "creating_account_name_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.creatingAccountPhonePlaceholder = NSLocalizedString(
            "creating_account_phone_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
     
        self.creatingAccountPasswordPlaceholder = NSLocalizedString(
            "creating_account_password_placeholder",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.profileName = NSLocalizedString(
            "profile_name",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.profileOrders = NSLocalizedString(
            "profile_orders",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.profileMyProfile = NSLocalizedString(
            "profile_my_profile",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
        
        self.profileAddresses = NSLocalizedString(
            "profile_addresses",
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
    }
}

enum Language {
    case ru
    case tj
    case en
    
    var code: String {
        switch self {
        case .ru:
            "ru"
        case .tj:
            "tg"
        case .en:
            "en"
        }
    }
}

