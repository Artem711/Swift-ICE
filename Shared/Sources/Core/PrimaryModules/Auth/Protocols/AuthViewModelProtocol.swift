//
//  AuthViewModels.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import Foundation

protocol AuthViewModelProtocol: ObservableObject {
    associatedtype LocalAuthNavigation: AuthNavigationManager
    var currentStep: LocalAuthNavigation { get set }
    
    var allowNext: Bool { get }
    var allowBack: Bool { get }
    
    func moveToNextScreen() -> Void
    func moveToBackScreen() -> Void
}

extension AuthViewModelProtocol {
    var allowNext: Bool { self.currentStep != LocalAuthNavigation.allCases.last }
    var allowBack: Bool { self.currentStep != LocalAuthNavigation.allCases.first }
    
    func moveToNextScreen() { if self.allowNext { self.currentStep = self.currentStep.next() }}
    func moveToBackScreen() { if self.allowBack { self.currentStep = self.currentStep.previous()} }
}
