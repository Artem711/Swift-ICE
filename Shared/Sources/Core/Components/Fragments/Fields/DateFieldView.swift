//
//  DateFieldView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct DateFieldView: View {
    @Binding var selectedDate: Date
    let mode: DatePickerComponents
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker("", selection: self.$selectedDate, displayedComponents: [self.mode])
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Error").errorTextStyle()
        }
    }
}

//struct DateFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        DateFieldView(mode: .init())
//            .previewComponent(with: "DateField View")
//    }
//}
