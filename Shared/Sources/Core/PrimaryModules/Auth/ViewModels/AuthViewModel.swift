//
//  AuthViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine

typealias LocalAuthNavigation = AuthNavigationStep
final class AuthViewModel: ObservableObject {
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first ?? LocalAuthNavigation.phoneNumber
    var allowNext: Bool { self.currentStep != LocalAuthNavigation.allCases.last }
    private var allowBack: Bool { self.currentStep != LocalAuthNavigation.allCases.first }
    
    @Published var loading = false
    @Published var phoneNumberCountry: CountryPhoneCode = .spain
    @Published var phoneNumber: String = ""
    @Published var passcode = ""
    @Published var passcodeVerification = ""
    
    func moveToNextScreen() { if self.allowNext {
        guard self.currentStep != .phoneNumber else {
            return
        }
        self.moveNext()
    } }
    
    func moveToBackScreen() { if self.allowBack { self.currentStep = self.currentStep.previous()} }
    
    private func moveNext() { self.currentStep = self.currentStep.next() }
}

