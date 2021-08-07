//
//  PrimaryButtonView.swift
//  ICE
//
//  Created by Артём Мошнин on 4/8/21.
//

import SwiftUI

struct TransparentButton: View {
    typealias ActionHandler = () -> Void
    
    let title: String?
    let icon: String?
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let handler: ActionHandler
    
    internal init(title: String? = nil,
                  icon: String? = nil,
                  backgroundColor: Color = .blue,
                  foregroundColor: Color = .white,
                  borderColor: Color = .clear,
                  handler: @escaping Self.ActionHandler) {
        self.title = title
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.handler = handler
    }
    
    var body: some View {
        Button(action: self.handler) {
            HStack(spacing: 21) {
                if let icon = self.icon {
                    Image(systemName: icon)
                }
                if let title = self.title {
                    Text(title)
                }
            }
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .background(Color.theme.blueShadow)
        .foregroundColor(self.foregroundColor)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(self.CORNER_RADIUS)
        .overlay(
            RoundedRectangle(cornerRadius: self.CORNER_RADIUS)
                .stroke(self.borderColor, lineWidth: 2)
        )
    }
    
    private let CORNER_RADIUS: CGFloat = 10
}

struct TransparentButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransparentButton(title: "Invest by yourself", icon: "at.badge.plus") {}
                .previewComponent(with: "PrimaryButton (title & icon)")
            TransparentButton(title: "Invest by yourself") {}
                .previewComponent(with: "PrimaryButton (title)")
            TransparentButton(icon: "at.badge.plus") {}
                .previewComponent(with: "PrimaryButton (icon)")
        }
    }
}
