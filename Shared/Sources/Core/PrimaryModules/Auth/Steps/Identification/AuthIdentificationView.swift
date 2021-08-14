//
//  AuthIdentificationView.swift
//  ICE
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

struct AuthIdentificationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthIdentificationView(registerViewModel: AuthRegistrationMenuViewModel())
    }
}
