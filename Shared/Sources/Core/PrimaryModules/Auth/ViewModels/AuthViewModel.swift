//
//  AuthViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine

final class AuthViewModel: ObservableObject {
    @Published var currentStep: AuthNavigationStep = AuthNavigationStep.allCases.first ?? AuthNavigationStep.email
    private var allowNext: Bool { self.currentStep != AuthNavigationStep.allCases.last }
    private var allowBack: Bool { self.currentStep != AuthNavigationStep.allCases.first }
    
    func nextScreen() { if self.allowNext { self.currentStep = self.currentStep.next()} }
    func backScreen() { if self.allowBack { self.currentStep = self.currentStep.previous()} }
}

