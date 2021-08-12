//
//  Text.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

extension Text {
    func titleTextStyle() -> some View {
        self
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(Color.theme.text)
    }
    func subtitleTextStyle() -> some View {
        self
            .font(.subheadline)
            .foregroundColor(Color.theme.subText)
    }
    func errorTextStyle() -> some View {
        self
            .foregroundColor(.red)
    }
}
