//
//  LoginView.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel(mode: .login)
    
    var body: some View {
        Text("LoginView")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
