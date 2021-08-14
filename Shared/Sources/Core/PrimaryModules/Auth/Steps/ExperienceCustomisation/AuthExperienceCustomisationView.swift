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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AuthExperienceCustomisationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthExperienceCustomisationView(registerViewModel: AuthRegistrationMenuViewModel())
    }
}
