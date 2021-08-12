//
//  TextFieldView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct TextFieldView: View {
    let component: TextFieldComponent
    var body: some View {
        VStack(alignment: .leading) {
            TextField(self.component.placeholder, text: .constant(""))
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .center)
                .padding(.leading, 5)
                .keyboardType(self.component.keyboardType)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.25))
                )
            
            Text("Error").errorTextStyle()
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(component: .init(placeholder: "Test placeholder"))
            .previewComponent(with: "TextField View")
    }
}
