//
//  AuthNavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

enum AuthNavigationStep: CaseIterable {
    case email
    case fullName
    case homeAddress
    
     var text: (title: String, description: String) {
        switch self {
        case .email:
            return (title: "Email title", description: "Email description")
        case .fullName:
            return (title: "Full name", description: "Full name description")
        case .homeAddress:
            return (title: "Home address", description: "Home address description")
        }
    }
    
    var fields: [FormComponent] {
        switch self {
        case .email:
            return [TextFormComponent(placeholder: "Hello email")]
        default:
            return [TextFormComponent(placeholder: "Hello default")]
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

protocol FormField: Identifiable {
    var id: UUID { get }
    var value: Any? { get }
}

class FormComponent: FormField {
    var id = UUID()
    var value: Any?
}

final class TextFormComponent: FormComponent {
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
}

final class DateFormComponent: FormComponent {
    let mode: UIDatePicker.Mode
    init(mode: UIDatePicker.Mode) {
        self.mode = mode
    }
}

final class ButtonFormComponent: FormComponent {
    let title: String
    init(title: String) {
        self.title = title
    }
}
