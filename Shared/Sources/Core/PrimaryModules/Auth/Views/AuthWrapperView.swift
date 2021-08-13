//
//  IndividualAuthView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct AuthWrapperView<Content: View, NavigationStep: AuthNavigationStepper>: View {
    typealias MoveNextActionHandler = () -> ()
    
    let item: NavigationStep
    let moveToNextScreen: MoveNextActionHandler
    let content: Content
    
    internal init(_ item: NavigationStep, moveToNextScreen: @escaping MoveNextActionHandler, @ViewBuilder content: @escaping () -> Content) {
        self.item = item
        self.moveToNextScreen = moveToNextScreen
        self.content = content()
    }
    
    var body: some View {
        VStack {
            self.midheader()
            LazyVGrid(columns: [GridItem(.flexible(minimum: 44))], spacing: 20) {self.content}
            self.footer(next: self.moveToNextScreen)
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

//struct AuthWrapperView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthWrapperView(AuthNavigationStep.verifyPhoneNumber, content: {Text("Hello")})
//            .environmentObject(AuthViewModel())
//    }
//}
