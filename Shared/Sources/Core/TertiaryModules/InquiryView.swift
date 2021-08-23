//
//  InquiryView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 23/8/21.
//

import SwiftUI

struct InquiryView: View {
    let title: String
    let subtitle: String
    let image: Image
    let acceptButtonText: String
    let denyButtonText: String
    
    var body: some View {
        VStack() {
            Spacer()
            Group {
                self.image
                Text(self.title).titleTextStyle()
                    .padding(.top, 10)
                Text(self.subtitle).subtitleTextStyle()
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
            }.foregroundColor(Color.theme.text)
            Spacer()
            Group {
                PrimaryButtonView(title: self.acceptButtonText) {}
                Button(action: {}, label: { Text(self.denyButtonText).fontWeight(.bold).subtitleTextStyle()
                }).padding(.top, 6)
            }
        }.padding(.horizontal)
    }
}

struct InquiryView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryView(title: "Allow Face ID", subtitle: "Would you like to securely log in into ICE using Face ID (Touch ID, depending on the model)?", image: Image(systemName: "star"), acceptButtonText: "Allow Face ID", denyButtonText: "No, thank you")
            .preferredColorScheme(.dark)
    }
}
