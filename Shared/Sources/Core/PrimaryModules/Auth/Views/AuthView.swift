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
        VStack {
            self.header.padding(.horizontal)
            TabView(selection: self.$viewModel.currentStep) {
                        AuthNavigationStep.list(viewModel: self.viewModel) }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .animation(.easeInOut)
                        .transition(.slide)
        }
    }
    
    private var header: some View {
        HStack {
            Button(action: self.viewModel.moveToBackScreen, label: {
                Label("Back icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
            })
            Spacer()
            Label("Question icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthView()
//            AuthView()
//                .preferredColorScheme(.dark)
        }
    }
}
