//
//  PersonalData.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

typealias LocalAuthNavigation = AuthPersonalDataStep
struct AuthPersonalDataView: AuthViewProtocol {
    typealias ViewModel = AuthPersonalDataViewModel
    
    @State var viewModel = ViewModel()
    var endHandler: ActionHandler

    var body: some View { self.wrapper(currentStep: self.$viewModel.currentStep) }
    
    @ViewBuilder func content(item: LocalAuthNavigation) -> some View {
        switch item {
        case .dateOfBirth, .parentsEmail, .parentsQRCode, .email, .verifyEmail, .fullName, .homeAddress:
            VStack {
                
            }
        
        }
    }
}


final class AuthPersonalDataViewModel: AuthViewModelProtocol {
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    @Published var loading = false
}
