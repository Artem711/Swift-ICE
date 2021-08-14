//
//  AuthViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine


protocol AuthViewModels: ObservableObject {
    associatedtype LocalAuthNavigation: AuthNavigationManager
    var currentStep: LocalAuthNavigation { get set }
    
    var allowNext: Bool { get }
    var allowBack: Bool { get }
    
    func moveToNextScreen() -> Void
    func moveToBackScreen() -> Void
}

final class AuthStartViewModel: AuthViewModels {
    typealias LocalAuthNavigation = AuthStartStep
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    
    var allowNext: Bool { self.currentStep != LocalAuthNavigation.allCases.last }
    var allowBack: Bool { self.currentStep != LocalAuthNavigation.allCases.first }
    
    @Published var loading = false
    @Published var phoneNumberCountry: CountryPhoneCode = .spain
    @Published var phoneNumber: String = ""
    @Published var passcode = ""
    @Published var passcodeVerification = ""
    
    func moveToNextScreen() { if self.allowNext { self.currentStep = self.currentStep.next() }}
    func moveToBackScreen() { if self.allowBack { self.currentStep = self.currentStep.previous()} }
}

