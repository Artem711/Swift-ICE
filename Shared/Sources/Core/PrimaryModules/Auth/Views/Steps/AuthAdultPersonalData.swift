//
//  PersonalData.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthAdultPersonalDataView: AuthViewProtocol {
    typealias LocalAuthNavigation = AuthAdultPersonalDataStep
    typealias ViewModel = AuthAdultPersonalDataViewModel
    
    @State var viewModel = ViewModel()
    var endHandler: ActionHandler
    var body: some View { self.wrapper(currentStep: self.$viewModel.currentStep) }
    
    @ViewBuilder func content(item: LocalAuthNavigation?) -> some View {
        if let item = item {
            switch item {
            case .email:
                VStack {}
            case .verifyEmail:
                VStack {}
            case .fullName:
                VStack {}
            case .homeAddress:
                VStack {}
            }
        }
    }
}


final class AuthAdultPersonalDataViewModel: AuthViewModelProtocol {
    typealias LocalAuthNavigation = AuthAdultPersonalDataStep
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    @Published var loading = false

    @Published var emailText = ""
    @Published var emailVerificationText = ""
    
    @Published var firstNameText = ""
    @Published var lastNameText = ""
    @Published var streetText = ""
    @Published var buildingText = ""
    @Published var postalCodeText = ""
    @Published var cityText = ""
    @Published var countryText = ""
}

enum AuthAdultPersonalDataStep: AuthNavigationManager {
    case email, verifyEmail, fullName, homeAddress
    
    var text: (title: String, description: String) {
        switch self {
        case .email:
            return ("What is your email?", "Associate your email to your ICE account.")
        case .verifyEmail:
            return ("Verify email", "Please, enter the code we’ve sent to")
        case .fullName:
            return ("Name", "As written on your official document. We need your name to verify your identity.")
        case .homeAddress:
            return ("Home address", "Enter your home address precisely. We need it to verify your identity.")
        }
    }
}

extension AuthAdultPersonalDataStep: Identifiable {
    var id: Self { self }
}

