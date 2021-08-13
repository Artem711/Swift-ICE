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
            AuthNavigationStep.list
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
