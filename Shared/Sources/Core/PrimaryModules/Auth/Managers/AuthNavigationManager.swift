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
    
    private var fields: [FormComponent] {
        switch self {
        case .email:
            return [TextFormComponent(placeholder: "Hello email")]
        default:
            return [TextFormComponent(placeholder: "Hello default")]
        }
    }
    
    func view(next: @escaping () -> (), back: @escaping () -> ()) -> some View {
        VStack {
            Text(self.text.title)
            Text(self.text.description)
            Button("Next", action: next)
        }
        .navigationBarItems(leading: self.backButton(back: back))
    }
    
    private func backButton(back: @escaping () -> ()) -> some View {
        
        Button(action: back) {
            HStack {
                Image("ic_back")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                Text("Go back")
            }
        }
    }
    
    static func list(viewModel: AuthViewModel) -> some View {

            ForEach(Self.allCases) { item in
                Desin(item).tag(item).environmentObject(viewModel)
            }
        
    }
}

extension AuthNavigationStep {
    struct Desin: View {
        let item: AuthNavigationStep
        @EnvironmentObject private var viewModel: AuthViewModel
        
        internal init(_ item: AuthNavigationStep) {
            self.item = item
        }
        
        var body: some View {
            self.item.view(next: self.viewModel.nextScreen, back: self.viewModel.backScreen)
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
