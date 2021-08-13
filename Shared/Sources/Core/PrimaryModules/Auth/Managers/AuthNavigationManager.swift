//
//  AuthNavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

protocol AuthNavigationStepper: CaseIterable, Identifiable {
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
}

extension AuthNavigationStep: Identifiable {
    var id: Self { self }
}
