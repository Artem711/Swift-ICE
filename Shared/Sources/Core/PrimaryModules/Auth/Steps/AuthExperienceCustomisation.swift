//
//  AuthExperienceCustomisation.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthExperienceCustomisationView: View {
    @ObservedObject var registerViewModel: AuthRegistrationMenuViewModel
    var body: some View {
        Text("Experience")
        Button("Done") { self.registerViewModel.doneHandler(item: .experienceCustomisation) }
    }
}

final class AuthExperienceCustomisationViewModel: ObservableObject {}
