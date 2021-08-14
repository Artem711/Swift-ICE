//
//  PersonalData.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthBirthDateView: AuthViewProtocol {
    typealias LocalAuthNavigation = AuthBirthDateStep
    typealias ViewModel = AuthBirthDateViewModel
    
    @State var viewModel = ViewModel()
    var endHandler: ActionHandler
    var body: some View { self.wrapper(currentStep: self.$viewModel.currentStep)}
    
    @ViewBuilder func content(item: LocalAuthNavigation) -> some View {
        return VStack {
            
        }
    }
}


final class AuthBirthDateViewModel: AuthViewModelProtocol {
    typealias LocalAuthNavigation = AuthBirthDateStep
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    @Published var loading = false
    var ageLimit: Int
    
    init(ageLimit: Int = 18) {
        self.ageLimit = ageLimit
    }
    
    var isAdult: Bool {
        if let calculatedYear = Calendar.current.dateComponents([.year], from: self.dateOfBirth, to: Date()).year, calculatedYear < self.ageLimit {
            return false
        }
        return true
    }
    
    @Published var dateOfBirth = Date()
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
