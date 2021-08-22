//
//  AuthBirthDateView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 22/8/21.
//

import SwiftUI

struct AuthBirthDateView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AuthBirthDateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthBirthDateView()
    }
}

enum AuthStartStep: AuthNavigationManager {
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
        }
    }
}

extension AuthStartStep: Identifiable {
    var id: Self { self }
}

enum AuthRegistrationMenuStep: AuthNavigationManager {
    case home
    
    var text: (title: String, description: String) {
        return ("Account created", "Just a few more steps - and you will be able to start investing. We are required to collect this data by law.")
    }
}

extension AuthRegistrationMenuStep: Identifiable {
    var id: Self { self }
}

