//
//  AuthNavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

protocol AuthNavigationStepper: CaseIterable, Identifiable {
    associatedtype ListReturn
    var text: (title: String, description: String, fields: [FormComponent]) { get }
    static func list(viewModel: AuthViewModel) -> ListReturn
}

enum AuthNavigationStepStart: AuthNavigationStepper {
    case phoneNumber, verifyPhoneNumber,createPasscode, confirmPasscode
    
    var text: (title: String, description: String, fields: [FormComponent]) {
        switch self {
        default:
            return ("","", [TextFieldComponent(placeholder: "Hello default")])
        }
    }
    
    static func list(viewModel: AuthViewModel) -> some View {
        ForEach(Self.allCases) { item in
            IndividualAuthView(item).tag(item).environmentObject(viewModel)
        }
    }
}

enum AuthNavigationStepPersonalData: AuthNavigationStepper {
    case dob, email, fullName, homeAddress
    
    var text: (title: String, description: String, fields: [FormComponent]) {
        switch self {
        case .email:
            return (title: "Email title", description: "Email description", [TextFieldComponent(placeholder: "Hello email")])
        case .fullName:
            return (title: "Full name", description: "Full name description", [TextFieldComponent(placeholder: "Hello default")])
        case .homeAddress:
            return (title: "Home address", description: "Home address description", [TextFieldComponent(placeholder: "Hello default")])
        default:
            return ("","", [TextFieldComponent(placeholder: "Hello default")])
        }
    }
    
    static func list(viewModel: AuthViewModel) -> some View {
        ForEach(Self.allCases) { item in
            IndividualAuthView(item).tag(item).environmentObject(viewModel)
        }
    }
}

enum AuthNavigationStepIdentification: AuthNavigationStepper {
    case documentChoice, frontOfIdCard, backOfIdCard, selfie, endVerification
    
    var text: (title: String, description: String, fields: [FormComponent]) {
        switch self {
        default:
            return ("","", [TextFieldComponent(placeholder: "Hello default")])
        }
    }
    
    static func list(viewModel: AuthViewModel) -> some View {
        ForEach(Self.allCases) { item in
            IndividualAuthView(item).tag(item).environmentObject(viewModel)
        }
    }
}

enum AuthNavigationStepInvestorProfile: AuthNavigationStepper {
    case start, question1, question2, question3, question4, question5, question6
    
    var text: (title: String, description: String, fields: [FormComponent]) {
        switch self {
        default:
            return ("","", [TextFieldComponent(placeholder: "Hello default")])
        }
    }
    
    static func list(viewModel: AuthViewModel) -> some View {
        ForEach(Self.allCases) { item in
            IndividualAuthView(item).tag(item).environmentObject(viewModel)
        }
    }
}

enum AuthNavigationStepExperienceCustomisation: AuthNavigationStepper {
    case faceIdChoice, notificationsChoice, modeChoice
    
    var text: (title: String, description: String, fields: [FormComponent]) {
        switch self {
        default:
            return ("","", [TextFieldComponent(placeholder: "Hello default")])
        }
    }
    
    static func list(viewModel: AuthViewModel) -> some View {
        ForEach(Self.allCases) { item in
            IndividualAuthView(item).tag(item).environmentObject(viewModel)
        }
    }
}


enum AuthNavigationStepGuide: AuthNavigationStepper {
    case home, investing, plus, social, academy, end
    
    var text: (title: String, description: String, fields: [FormComponent]) {
        switch self {
        default:
            return ("","", [TextFieldComponent(placeholder: "Hello default")])
        }
    }
    
    static func list(viewModel: AuthViewModel) -> some View {
        ForEach(Self.allCases) { item in
            IndividualAuthView(item).tag(item).environmentObject(viewModel)
        }
    }
}

extension AuthNavigationStep: Identifiable {
    var id: Self { self }
}

struct AuthNavigator {
    var step: AuthNavigationStep
    var fields: [FormComponent]
}
