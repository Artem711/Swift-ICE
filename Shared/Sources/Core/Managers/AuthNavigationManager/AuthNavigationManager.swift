//
//  AuthNavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

protocol AuthNavigationStepper: CaseIterable, Identifiable {
    associatedtype T: View
    
    static var list: T { get }
    var text: (title: String, description: String, fields: [FormComponent]) { get }
}

enum AuthNavigationStep: AuthNavigationStepper {
    case phoneNumber, verifyPhoneNumber,createPasscode, confirmPasscode
    
    var text: (title: String, description: String, fields: [FormComponent]) {
        switch self {
        case .phoneNumber:
            return ("Sign up to ICE", "Please, enter your phone number to create a new account or to log in to an existing one", [PhoneNumberSelectorComponent(), TextFieldComponent(placeholder: "Hello default")])
        case .verifyPhoneNumber:
            return ("Verify numebr", "Please enter the code we’ve sent to", [CellsFieldComponent()])
        case .createPasscode:
            return ("Create your passcode", "Passcode will be used when entering the app", [PasscodeCellsFieldComponent()])
        case .confirmPasscode:
            return ("Confirm your passcode", "Passcode will be used when entering the app", [PasscodeCellsFieldComponent()])
        default:
            return ("","", [TextFieldComponent(placeholder: "Hello default")])
        }
    }
    
    static var list: some View { AuthScreensListView() }
}

struct AuthScreensListView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        TabView(selection: self.$viewModel.currentStep) {
            ForEach(AuthNavigationStep.allCases) { item in
                VStack {
                    self.header
                    IndividualAuthView(item).tag(item).environmentObject(self.viewModel)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut)
        .transition(.slide)
    }
    
    private var header: some View {
        HStack {
            Button(action: self.viewModel.moveToBackScreen, label: {
                Label("Back icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
            })
            Spacer()
            Label("Question icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
        }
        .padding(.horizontal)
    }
}

extension AuthNavigationStep: Identifiable {
    var id: Self { self }
}

struct AuthNavigator {
    var step: AuthNavigationStep
    var fields: [FormComponent]
}
