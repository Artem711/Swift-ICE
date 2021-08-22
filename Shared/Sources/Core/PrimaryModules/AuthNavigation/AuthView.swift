//
//  AuthView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 22/8/21.
//

import SwiftUI



struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                AuthStarterView(viewModel: self.viewModel)
                
                Group {
                    NavigationLink(
                        destination: AuthLoginView(viewModel: self.viewModel),
                        tag: .login,
                        selection: self.$viewModel.authMove,
                        label: {EmptyView()})
                    
                    NavigationLink(
                        destination: AuthPreRegistrationMenuView(viewModel: self.viewModel),
                        tag: .register,
                        selection: self.$viewModel.authMove,
                        label: {EmptyView()})
                }.hidden()
            }
            .navigationBarHidden(true)
        }
    }
}

struct AuthStarterView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        AuthWrapperView(item: AuthStarterEnum.self, content: { _ in
            HStack {
                TextFieldView(
                    placeholder: "Placeholder",
                    text: self.$viewModel.phoneNumQuestField,
                    errorText: self.$viewModel.phoneNumQuestErrorText)
            }
        }, onGoNext: {_ in self.viewModel.phoneNumQuestNext()},
        nextButtonDisabled: !self.viewModel.phoneNumQuestValid)
    }
}

struct AuthLoginView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        AuthWrapperView(item: AuthLoginEnum.self, content: { _ in
            PasscodeView()
        }, onGoBack: {_ in self.viewModel.authMove = nil})
    }
}

struct AuthPreRegistrationMenuView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        AuthWrapperView(item: AuthPreRegMenuEnum.self, content: { item in
            Group {
                switch item {
                case .phoneNumVerification:
                    TextFieldView(placeholder: "x",
                                  text: self.$viewModel.phoneNumVerificationQuestField,
                                  errorText: self.$viewModel.phoneNumQuestErrorText)
                case .passcodeCreation:
                    TextFieldView(placeholder: "x",
                                  text: self.$viewModel.passcodeCreationQuestField,
                                  errorText: self.$viewModel.passcodeCreationQuestErrorText)
                case .passcodeVerification:
                    TextFieldView(placeholder: "x",
                                  text: self.$viewModel.passcodeVerificationQuestField,
                                  errorText: self.$viewModel.passcodeVerificationQuestErrorText)
                }
            }
        }, allowNext: { item in
            switch item {
            case .phoneNumVerification:
                return self.viewModel.phoneNumVerificationQuestValid
            case .passcodeCreation:
                return self.viewModel.passcodeCreationQuestValid
            case .passcodeVerification:
                return self.viewModel.passcodeVerificationQuestValid
            }
        }, allowBack: {_ in true })
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

enum AuthStarterEnum: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("StarterEnum", "StarterEnumDesc")
    }
}

extension AuthStarterEnum: Identifiable { var id: Self { self } }

enum AuthLoginEnum: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("LoginEnum", "LoginEnumDesc")
    }
}

extension AuthLoginEnum: Identifiable { var id: Self { self } }

enum AuthPreRegMenuEnum: AuthNavigationManager {
    case phoneNumVerification, passcodeCreation, passcodeVerification
    var text: (title: String, description: String) {
        switch self {
        case .phoneNumVerification:
            return ("phoneNumVerification", "phoneNumVerificationdesc")
        case .passcodeCreation:
            return ("passcodeCreation", "passcodeCreationdesc")
        case .passcodeVerification:
            return ("passcodeVerification", "passcodeVerificationdesc")
        }
    }
}

extension AuthPreRegMenuEnum: Identifiable { var id: Self { self } }

