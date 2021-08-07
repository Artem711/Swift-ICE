//
//  LoginView.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Text("Create an account")
            Button("Sign up") {}
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
