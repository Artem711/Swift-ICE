//
//  PreviewLayoutComponentModifier.swift
//  ICE
//
//  Created by Артём Мошнин on 4/8/21.
//

import SwiftUI

struct PreviewLayoutComponentModifier: ViewModifier {
    let name: String
    
    func body(content: Content) -> some View {
        Group {
            content
            content
                .preferredColorScheme(.dark)
        }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("\(name) Component")
            .padding()
    }
}

extension View {
    func previewComponent(with name: String) -> some View {
        self.modifier(PreviewLayoutComponentModifier(name: name))
    }
}
