//
//  AuthNavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

protocol AuthNavigationManager: CaseIterable, Identifiable, Hashable, Equatable where AllCases: BidirectionalCollection & RandomAccessCollection {
    var text: (title: String, description: String) { get }
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
        default:
            return ("","")
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

enum AuthPersonalDataStep: AuthNavigationManager {
    case dateOfBirth, parentsEmail, parentsQRCode, email, verifyEmail, fullName, homeAddress
    
    var text: (title: String, description: String) {
        switch self {
        case .dateOfBirth:
            return ("Date of birth", "As written on your official document. You need to be over 18 to open a full account (over 15 for a custodial account).")
        case .parentsEmail:
            return ("Your parent’s email", "We’ve noticed that you are under 18. Please, enter one of your parent’s (or legal guardian’s) email to proceed")
        case .parentsQRCode:
            return ("Please, wait...", """
Email(s) has been sent. Please, tell your parent to
                check their email or scan the code below and follow
                the instructions. You will be able to access your account
                as soon as the parent completes all the steps required.
""")
        case .email:
            return ("What is your email?", "Associate your email to your ICE account.")
        case .verifyEmail:
            return ("Verify email", "Please, enter the code we’ve sent to")
        case .fullName:
            return ("Name", "As written on your official document. We need your name to verify your identity.")
        case .homeAddress:
            return ("Home address", "Enter your home address precisely. We need it to verify your identity.")
        }
    }
}

extension AuthPersonalDataStep: Identifiable {
    var id: Self { self }
}
