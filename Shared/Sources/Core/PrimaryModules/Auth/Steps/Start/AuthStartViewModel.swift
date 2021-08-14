//
//  AuthViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine

final class AuthStartViewModel: AuthViewModelProtocol {
    typealias LocalAuthNavigation = AuthStartStep
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    @Published var loading = false
    
    @Published var phoneNumberCountryText: CountryPhoneCode = .spain
    @Published var phoneNumberText: String = ""
    @Published var passcodeText = ""
    @Published var passcodeVerificationText = ""
}

