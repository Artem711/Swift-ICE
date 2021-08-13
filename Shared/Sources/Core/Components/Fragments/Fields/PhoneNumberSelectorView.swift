//
//  PhoneNumberSelectorView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct PhoneNumberSelectorView: View {
    @State private var sheetOpened = false
    @Binding var countryNumbder: CountryPhoneCode
    
    var body: some View {
        VStack {
            Text("Country")
            HStack { Text(self.countryNumbder.rawValue.description) }
        }
        .onTapGesture { self.sheetOpened.toggle() }
        .sheet(isPresented: self.$sheetOpened, content: {
                CountryPhonesListView(sheetOpened: self.$sheetOpened, onSelectAction: self.onCountryNumberSelected) })
    }
    
    private func onCountryNumberSelected(number: CountryPhoneCode) { self.countryNumbder = number }
}

//struct PhoneNumberSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhoneNumberSelectorView(countryNumbder: .constant(.spain))
//            .previewComponent(with: "PhoneNumberSelector View")
//    }
//}
