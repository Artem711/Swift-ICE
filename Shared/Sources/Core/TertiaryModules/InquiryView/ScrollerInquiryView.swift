//
//  ScrollerInquiryView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 23/8/21.
//

import SwiftUI

struct ScrollerInquiryView<NavigationStep: AuthNavigationManager>: View {
    typealias ButtonHandler = (_ item: NavigationStep) -> Void
    @State private var item: NavigationStep = NavigationStep.allCases.first!
    let acceptButtonHandler: ButtonHandler
    let denyButtonHandler: ButtonHandler

    internal init(
        item: NavigationStep.Type,
        acceptButtonHandler: @escaping ButtonHandler,
        denyButtonHandler: @escaping ButtonHandler) {
        self.acceptButtonHandler = acceptButtonHandler
        self.denyButtonHandler = denyButtonHandler
    }
    
    
    var body: some View {
        HorizontalPageScroller(item: self.$item) { localItem in
            VStack {
                if let data = localItem.inquiryData {
                    InquiryView(
                        title: localItem.text.title,
                        subtitle: localItem.text.description,
                        image: data.image, acceptButtonText: data.acceptButtonText,
                        denyButtonText: data.denyButtonText,
                        acceptButtonHandler: {self.acceptButtonHandler(localItem)},
                        denyButtonHandler: {self.denyButtonHandler(localItem)}
                        )
                }
            }
        }
    }
}
