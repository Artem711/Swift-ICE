//
//  AuthIdentification.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthIdentificationView: View {
    @ObservedObject var registerViewModel: AuthRegistrationMenuViewModel
    var body: some View {
        Text("AuthIdentificationView")
        Button("Done") { self.registerViewModel.doneHandler(item: .identification) }
    }
}

final class AuthIdentificationViewModel: ObservableObject {}
