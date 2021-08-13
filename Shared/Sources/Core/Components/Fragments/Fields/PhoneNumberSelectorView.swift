//
//  PhoneNumberSelectorView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct PhoneNumberSelectorView: View {
    let component: PhoneNumberSelectorComponent
    var body: some View {
        Text("PhoneNumberSelectorView")
    }
}

struct PhoneNumberSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberSelectorView(component: .init())
            .previewComponent(with: "PhoneNumberSelector View")
    }
}
