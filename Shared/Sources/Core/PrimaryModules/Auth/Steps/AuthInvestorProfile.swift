//
//  AuthInvestorProfile.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthInvestorProfileView: View {
    @ObservedObject var registerViewModel: AuthRegistrationMenuViewModel
    var body: some View {
        Text("AuthInvestorProfileView")
        Button("Done") { self.registerViewModel.doneHandler(item: .investorProfile) }
    }
}

final class AuthInvestorProfileViewModel: ObservableObject {}
