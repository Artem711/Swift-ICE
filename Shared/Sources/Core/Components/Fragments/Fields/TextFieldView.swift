//
//  TextFieldView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    @Binding var text: String
    var errorText: FieldError
    let keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.txt).errorTextStyle()
            TextField(self.placeholder, text: self.$text)
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .center)
                .padding(.leading, 5)
                .keyboardType(self.keyboardType)
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.25))
                )
            
            
        
        }
    }
    
    var txt: String {
        if self.errorText != .valid && self.errorText != .silent {
            return self.errorText.rawValue
        } else {
            return ""
        }
    }
}

//struct TextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldView(component: .init(placeholder: "Test placeholder"))
//            .previewComponent(with: "TextField View")
//            .environmentObject(AuthViewModel())
//    }
//}
