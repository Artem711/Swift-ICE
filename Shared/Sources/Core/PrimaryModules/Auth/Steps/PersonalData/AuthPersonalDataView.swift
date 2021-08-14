//
//  AuthPersonalDataView.swift
//  ICE
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

struct AuthPersonalDataView: View {
    @ObservedObject var registerViewModel: AuthRegistrationMenuViewModel
    var body: some View {
        VStack {
            Text("AuthPersonalDataView")
            Button("Done") { self.registerViewModel.doneHandler(item: .personalData) }
        }
    }
}

struct AuthPersonalDataView_Previews: PreviewProvider {
    static var previews: some View {
        AuthPersonalDataView(registerViewModel: AuthRegistrationMenuViewModel())
    }
}
