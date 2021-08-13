//
//  LoginView.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine

struct AuthView: View {
    var body: some View {
        VStack {
                AuthStartView()
            
            
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthView()
                .preferredColorScheme(.dark)
        }
    }
}

enum AuthSteps {
    // Start
    case start
    
    // Login
    case login
    
    // Registration
    case registrationMenu
    case personalData
    case identification
    case investorProfile
    case experienceCustomisation
}
