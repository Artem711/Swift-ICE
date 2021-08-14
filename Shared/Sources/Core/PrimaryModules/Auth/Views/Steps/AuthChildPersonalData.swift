//
//  PersonalData.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthChildPersonalDataView: AuthViewProtocol {
    typealias LocalAuthNavigation = AuthPersonalChildDataStep
    typealias ViewModel = AuthChildPersonalDataViewModel
    
    @State var viewModel = ViewModel()
    var endHandler: ActionHandler
    var body: some View { self.wrapper(currentStep: self.$viewModel.currentStep) }
    
    @ViewBuilder func content(item: LocalAuthNavigation?) -> some View {
        if let item = item {
            switch item {
            case .parentEmail:
                VStack {}
            case .parentQRCode:
                VStack {}
            }
        }
    }
}


final class AuthChildPersonalDataViewModel: AuthViewModelProtocol {
    typealias LocalAuthNavigation = AuthPersonalChildDataStep
    
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    @Published var loading = false

    @Published var parentEmailText = ""
}

enum AuthPersonalChildDataStep: AuthNavigationManager {
    case parentEmail, parentQRCode
    
    var text: (title: String, description: String) {
        switch self {
        case .parentEmail:
            return ("Your parent’s email", "We’ve noticed that you are under 18. Please, enter one of your parent’s (or legal guardian’s) email to proceed")
        case .parentQRCode:
            return ("Please, wait...", """
Email(s) has been sent. Please, tell your parent to
                check their email or scan the code below and follow
                the instructions. You will be able to access your account
                as soon as the parent completes all the steps required.
""")
        }
    }
}

extension AuthPersonalChildDataStep: Identifiable {
    var id: Self { self }
}

