//
//  PersonalData.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthBirthDateView: AuthViewProtocol {
    typealias ViewModel = AuthBirthDateViewModel
    typealias LocalAuthNavigation = AuthBirthDateStep
    @StateObject var viewModel = AuthBirthDateViewModel()
    var endHandler: Self.ActionHandler
    
    var body: some View { self.wrapper(currentStep: self.$viewModel.currentStep) }
    
    @ViewBuilder func content(item: AuthBirthDateStep?) -> some View {
            DateFieldView(selectedDate: self.$viewModel.selectedDate, mode: .date)
    }
  
}

final class AuthBirthDateViewModel: AuthViewModelProtocol {
    typealias LocalAuthNavigation = AuthBirthDateStep
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    @Published var loading = false
    @Published var selectedDate = Date()
}

enum AuthBirthDateStep: AuthNavigationManager {
    case x
    var text: (title: String, description: String) {
        return ("Date of birth", "As written on your official document. You need to be over 18 to open a full account (over 15 for a custodial account).")
    }
}

extension AuthBirthDateStep: Identifiable {
    var id: Self { self }
}
