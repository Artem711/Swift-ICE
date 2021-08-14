//
//  LoginView.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine

struct AuthView: View {
    @State private var goToRegistration: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                AuthStartView(goToRegistration: self.$goToRegistration)
                NavigationLink(destination:
                                AuthRegistrationMenuView()
                                .navigationBarHidden(true),
                    isActive: self.$goToRegistration) { EmptyView() }
                .hidden()
            }
            .navigationBarHidden(true)
            
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthView().preferredColorScheme(.dark)
        }
    }
}
