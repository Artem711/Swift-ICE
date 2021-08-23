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
                    .onAppear {self.viewModel.subscribe()}
                
                Group {
                    NavigationLink(
                        destination: AuthLoginView(viewModel: self.viewModel)
                            .onAppear{self.viewModel.subscribe()},
                        tag: .login,
                        selection: self.$viewModel.authMove,
                        label: {EmptyView()})
                    
                    NavigationLink(
                        destination: AuthPreRegistrationMenuView(viewModel: self.viewModel)
                            .onAppear{self.viewModel.subscribe()},
                        tag: .register,
                        selection: self.$viewModel.authMove,
                        label: {EmptyView()})
                    
                    NavigationLink(
                        destination: AuthRegistrationMenuView(viewModel: self.viewModel),
                        tag: .registerMenu,
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
                    errorText: self.viewModel.phoneNumQuestErrorText)
            }
        }, onGoNext: {_ in self.viewModel.phoneNumQuestNext()},
        nextButtonDisabled: { _ in self.viewModel.phoneNumQuestErrorText != .valid})
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
                                  errorText: self.viewModel.phoneNumVerificationQuestErrorText)
                case .passcodeCreation:
                    
                        TextFieldView(placeholder: "x",
                                      text: self.$viewModel.passcodeCreationQuestField,
                                  errorText: self.viewModel.passcodeCreationQuestErrorText)
                    
                case .passcodeVerification:
                        TextFieldView(placeholder: "x",
                                      text: self.$viewModel.passcodeVerificationQuestField,
                                  errorText: self.viewModel.passcodeVerificationQuestErrorText)
                    
                }
            }
        }, onGoNext: { item in
            switch item {
            case .passcodeVerification:
                self.viewModel.passcodeVerificationQuestNext()
            default: {}()
            }
        }, onGoBack: { item in
            switch item {
            case .phoneNumVerification:
                self.viewModel.phoneNumVerificationQuestBack()
            default: {}()
            }
        }, nextButtonDisabled: { item in
            switch item {
            case .phoneNumVerification:
                return self.viewModel.phoneNumVerificationQuestErrorText != .valid
            case .passcodeCreation:
                return self.viewModel.passcodeCreationQuestErrorText != .valid
            case .passcodeVerification:
                return self.viewModel.passcodeVerificationQuestErrorText != .valid
            }
        })
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

