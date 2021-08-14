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
        Text("AuthPersonalDataView")
    }
}

struct AuthPersonalDataView_Previews: PreviewProvider {
    static var previews: some View {
        AuthPersonalDataView(registerViewModel: AuthRegistrationMenuViewModel())
    }
}
