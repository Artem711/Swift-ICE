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
    var text: (title: String, description: String) { get }
}

enum AuthNavigationStep: AuthNavigationStepper {
    case phoneNumber, verifyPhoneNumber,createPasscode, confirmPasscode
    
    var text: (title: String, description: String) {
        switch self {
        case .phoneNumber:
            return ("Sign up to ICE", "Please, enter your phone number to create a new account or to log in to an existing one")
        case .verifyPhoneNumber:
            return ("Verify numebr", "Please enter the code we’ve sent to")
        case .createPasscode:
            return ("Create your passcode", "Passcode will be used when entering the app" )
        case .confirmPasscode:
            return ("Confirm your passcode", "Passcode will be used when entering the app")
        default:
            return ("","")
        }
    }
    
    static var list: some View { AuthScreensListView() }
}

struct AuthScreensListView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        
        VStack {
            self.header
            TabView(selection: self.$viewModel.currentStep.animation()) {
                ForEach(AuthNavigationStep.allCases) { item in
                     IndividualAuthView(item, content: {self.content(item: item)})
                        .environmentObject(self.viewModel)
                        .tag(item)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
        }
    }
    
    private func content(item: AuthNavigationStep) -> some View {
        VStack {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 44))], spacing: 20) {
                switch item {
                case .phoneNumber:
                    HStack {
                        PhoneNumberSelectorView(countryNumbder: self.$viewModel.phoneNumberCountry)
                        TextFieldView(placeholder: "Mobile number", text: self.$viewModel.phoneNumber)
                    }
                default:
                    Text("dksd")
//                    TextFieldView(component: )
                }
            }
        }
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
