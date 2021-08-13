//
//  CountryPhoneNumbersListView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct CountryPhonesListView: View {
    @Binding var sheetOpened: Bool
    let onSelectAction: (_ item: CountryPhoneCode) -> Void
    
    var body: some View {
        ForEach(CountryPhoneCode.allCases) { item in
            CountryPhoneRowView(item: item).onTapGesture { self.onRowClick(item: item) } }
    }
    
    private func onRowClick(item: CountryPhoneCode) {
        self.onSelectAction(item)
        self.sheetOpened = false
    }
}

struct CountryPhoneRowView: View {
    let item: CountryPhoneCode
    
    var body: some View {
        HStack {
            Text(self.item.rawValue.description)
            Text(String(describing: self.item))
        }
    }
}

//struct CountryPhonesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryPhonesListView()
//    }
//}
