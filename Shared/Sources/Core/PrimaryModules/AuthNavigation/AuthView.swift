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
                AuthWrapperView(item: PhoneNumber.x, content: {
                    HStack {
                        TextFieldView(
                            placeholder: "Placeholder",
                            text: self.$viewModel.phoneNumQuestField,
                            errorText: self.$viewModel.phoneNumQuestErrorText)
                    }
                }, onGoNext: self.viewModel.phoneNumQuestNext,
                nextButtonDisabled: !self.viewModel.phoneNumQuestValid)
                
                Group {
                    NavigationLink(
                        destination: LoginView(),
                        tag: .login,
                        selection: self.$viewModel.authMove,
                        label: {EmptyView()})
                    
                    NavigationLink(
                        destination: AuthRegistrationMenuView(viewModel: self.viewModel),
                        tag: .register,
                        selection: self.$viewModel.authMove,
                        label: {EmptyView()})
                }.hidden()
            }
            .onAppear(perform: self.viewModel.subscribe)
            .navigationBarHidden(true)
        }
    }
}

struct LoginView: View {
    var body: some View {
        AuthWrapperView(item: LoginPasscode.x) {
            PasscodeView()
        }
    }
}



struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

enum PhoneNumber: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("PhoneNumberView", "PhoneNumberViewDesc")
    }
}

extension PhoneNumber: Identifiable { var id: Self { self } }

enum LoginPasscode: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("PhoneNumberView", "PhoneNumberViewDesc")
    }
}

extension LoginPasscode: Identifiable { var id: Self { self } }
