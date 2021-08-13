//
//  IndividualAuthView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct AuthWrapperView<Content: View, NavigationStep: AuthNavigationManager>: View {
    typealias MoveNextActionHandler = () -> Void
    
    let item: NavigationStep
    let content: Content
    let moveToNextScreen: MoveNextActionHandler?
    
    internal init(_ item: NavigationStep, @ViewBuilder content: @escaping () -> Content, moveToNextScreen: MoveNextActionHandler? = nil) {
        self.item = item
        self.content = content()
        self.moveToNextScreen = moveToNextScreen
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            self.midheader()
            LazyVGrid(columns: [GridItem(.flexible(minimum: 44))], spacing: 20) {self.content}
            if let moveFn = self.moveToNextScreen {
                self.footer(next: moveFn)
            }
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
