//
//  IndividualAuthView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct IndividualAuthView<Content: View>: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    let item: AuthNavigationStep
    let content: Content
    
    internal init(_ item: AuthNavigationStep, @ViewBuilder content: @escaping () -> Content) {
        self.item = item
        self.content = content()
    }
    
    var body: some View {
        VStack {
            self.midheader()
            self.content
            self.footer(next: self.viewModel.moveToNextScreen)
            Spacer()
        }.padding(.horizontal)
    }
    
    private func midheader() -> some View {
        VStack(alignment: .leading) {
            Text(self.item.text.title).titleTextStyle()
            Text(self.item.text.description).subtitleTextStyle()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
    }
    
    private func footer(next: @escaping () -> ()) -> some View {
        HStack {
            Spacer()
            Button("Next", action: next)
        }
    }

}

//struct IndividualAuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualAuthView(AuthNavigationStep.verifyPhoneNumber, content: {Text("Hello")})
//            .environmentObject(AuthViewModel())
//    }
//}
