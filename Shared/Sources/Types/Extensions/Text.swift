//
//  Text.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI


extension Text {
    func titleTextStyle(reduced: Bool = false) -> some View {
        self
            .fontWeight(.bold)
            .font(reduced ? .title3 : .title)
            .foregroundColor(Color.theme.text)
    }
    func subtitleTextStyle(reduced: Bool = false) -> some View {
        self
            .font(reduced ? .caption : .footnote)
            .foregroundColor(Color.theme.subText)
    }
    func errorTextStyle() -> some View {
        self
            .foregroundColor(.red)
    }
}
