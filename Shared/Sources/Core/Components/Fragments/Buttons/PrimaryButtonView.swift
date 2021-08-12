
//
//  PrimaryButtonView.swift
//  ICE
//
//  Created by Артём Мошнин on 4/8/21.
//

import SwiftUI

struct PrimaryButtonView: View {
    typealias ActionHandler = () -> Void
    let handler: ActionHandler = {}
    let component: PrimaryButtonComponent
    
    internal init(component: PrimaryButtonComponent) {
        self.component = component
    }
    
    var body: some View {
        Button(action: self.handler) {
            Text(self.component.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .background(self.component.backgroundColor)
        .foregroundColor(self.component.foregroundColor)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(self.CORNER_RADIUS)
        .overlay(
            RoundedRectangle(cornerRadius: self.CORNER_RADIUS)
                .stroke(self.component.borderColor, lineWidth: 2)
        )
    }
    
    private let CORNER_RADIUS: CGFloat = 10
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(component: .init(title: "Hello"))
            .previewComponent(with: "PrimaryButton")
    }
}
