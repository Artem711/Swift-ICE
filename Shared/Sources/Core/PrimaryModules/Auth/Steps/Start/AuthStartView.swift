//
//  InitiationAuthView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct AuthStartView: AuthViewProtocol {
    typealias ViewModel = AuthStartViewModel
    typealias LocalAuthNavigation = AuthStartStep
    
    @StateObject var viewModel = ViewModel()
    var endHandler: ActionHandler
    
    var body: some View { self.wrapper(currentStep: self.$viewModel.currentStep) }
    
    @ViewBuilder func content(item: LocalAuthNavigation) -> some View {
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

//struct AuthStartView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthStartView()
//    }
//}
