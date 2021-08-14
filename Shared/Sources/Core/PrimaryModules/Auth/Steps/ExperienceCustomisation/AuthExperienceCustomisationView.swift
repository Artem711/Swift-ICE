//
//  AuthExperienceCustomisationView.swift
//  ICE
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

struct AuthExperienceCustomisationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthExperienceCustomisationView(registerViewModel: AuthRegistrationMenuViewModel())
    }
}
