//
//  AuthInvestorProfileView.swift
//  ICE
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

struct AuthInvestorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AuthInvestorProfileView(registerViewModel: AuthRegistrationMenuViewModel())
    }
}
