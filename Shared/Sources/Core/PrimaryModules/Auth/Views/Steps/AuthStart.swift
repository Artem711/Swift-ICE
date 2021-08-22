//
//  Start.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthStartView: AuthViewProtocol {
    typealias LocalAuthNavigation = AuthStartStep
    typealias ViewModel = AuthStartViewModel
    
    @StateObject var viewModel = ViewModel()
    var endHandler: ActionHandler
    var body: some View { self.wrapper(currentStep: self.$viewModel.currentStep) }
    
    @ViewBuilder func content(item: LocalAuthNavigation?) -> some View {
        if let item = item {
            switch item {
            case .phoneNumber:
                HStack {
                    PhoneNumberSelectorView(countryNumbder: self.$viewModel.phoneNumberCountryText)
                    TextFieldView(placeholder: "Mobile number", text: self.$viewModel.phoneNumberText)
                }
            case .verifyPhoneNumber:
                VStack {
                    CellsFieldView()
                    HStack {
                        Text("Didn't receive the code?").subtitleTextStyle()
                        Spacer()
                        Text("0:59").subtitleTextStyle()
                    }
                }
            case .createPasscode:
                VStack {
                    CellsFieldView()
                    NumberPadView()
                }
            case .confirmPasscode:
                VStack {
                    CellsFieldView()
                    NumberPadView()
                }
            }
        }
    }
}

final class AuthStartViewModel: AuthViewModelProtocol {
    typealias LocalAuthNavigation = AuthStartStep
    @Published var currentStep: LocalAuthNavigation = LocalAuthNavigation.allCases.first!
    @Published var loading = false
    
    @Published var phoneNumberCountryText: CountryPhoneCode = .spain
    @Published var phoneNumberText: String = ""
    @Published var passcodeText = ""
    @Published var passcodeVerificationText = ""
}

