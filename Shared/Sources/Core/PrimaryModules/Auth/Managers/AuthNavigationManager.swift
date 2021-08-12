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
            return [TextFieldComponent(placeholder: "Hello email")]
        default:
            return [TextFieldComponent(placeholder: "Hello default")]
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
    
    @ViewBuilder func view(component: FormComponent) -> some View {
        switch self {
        case is TextFieldComponent:
            TextFieldView(component: component)
        case is DateFieldComponent:
            DateFieldView()
        case is PrimaryButtonComponent:
            PrimaryButtonView(title: "", handler: {})
        default:
            EmptyView()
        }
    }
}

final class TextFieldComponent: FormComponent {
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
}

final class DateFieldComponent: FormComponent {
    let mode: UIDatePicker.Mode
    init(mode: UIDatePicker.Mode) {
        self.mode = mode
    }
}

final class PrimaryButtonComponent: FormComponent {
    let title: String
    init(title: String) {
        self.title = title
    }
}
