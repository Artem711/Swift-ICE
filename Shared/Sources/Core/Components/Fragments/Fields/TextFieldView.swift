//
//  TextFieldView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct TextFieldView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Placeholder here", text: .constant(""))
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .center)
                .padding(.leading, 5)
                .keyboardType(.default)
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
        TextFieldView()
            .previewComponent(with: "TextField View")
    }
}
