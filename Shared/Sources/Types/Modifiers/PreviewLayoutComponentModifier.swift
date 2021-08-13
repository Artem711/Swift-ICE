//
//  PreviewLayoutComponentModifier.swift
//  ICE
//
//  Created by Артём Мошнин on 4/8/21.
//

import SwiftUI

struct PreviewLayoutComponentModifier: ViewModifier {
    let name: String
    let darkOnly: Bool
    
    init(name: String, darkOnly: Bool = false) {
        self.name = name
        self.darkOnly = darkOnly
    }
    
    func body(content: Content) -> some View {
        Group {
            if !self.darkOnly {
                content
            }
            content
                .preferredColorScheme(.dark)
        }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("\(name) Component")
            .padding()
    }
}

extension View {
    func previewComponent(with name: String, darkOnly: Bool = false) -> some View {
        self.modifier(PreviewLayoutComponentModifier(name: name, darkOnly: darkOnly))
    }
}
