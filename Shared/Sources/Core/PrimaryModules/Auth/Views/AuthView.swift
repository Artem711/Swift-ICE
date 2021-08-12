//
//  LoginView.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
            TabView(selection: self.$viewModel.currentStep) {
                AuthNavigationStep.list(viewModel: self.viewModel) }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut)
                .transition(.slide)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
