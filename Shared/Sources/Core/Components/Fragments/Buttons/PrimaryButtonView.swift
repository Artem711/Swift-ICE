
//
//  PrimaryButtonView.swift
//  ICE
//
//  Created by Артём Мошнин on 4/8/21.
//

import SwiftUI

struct PrimaryButtonView: View {
    typealias ActionHandler = () -> Void
    
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let minHeight: CGFloat
    let handler: ActionHandler

    internal init(title: String, backgroundColor: Color = Color.theme.accent, foregroundColor: Color = Color.theme.text, borderColor: Color = .clear, minHeight: CGFloat = 0, handler: @escaping ActionHandler) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.minHeight = minHeight
        self.handler = handler
    }
    
    var body: some View {
        Button(action: self.handler) {
            Text(self.title)
                .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .background(self.backgroundColor)
        .foregroundColor(self.foregroundColor)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(self.CORNER_RADIUS)
        .overlay(
            RoundedRectangle(cornerRadius: self.CORNER_RADIUS)
                .stroke(self.borderColor, lineWidth: 2)
        )
        .frame(minHeight: self.minHeight)
    }
    
    private let CORNER_RADIUS: CGFloat = 10
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(title: "Hello") { print("Hello print") }
            .previewComponent(with: "PrimaryButton")
    }
}
