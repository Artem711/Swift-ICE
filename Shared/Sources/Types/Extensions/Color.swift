//
//  Color.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 3/8/21.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

let darkBlue = Color("DarkBlue")

struct ColorTheme {
    let background = Color("BackgroundColor")
    let accent = Color("AccentColor")
    let blueShadow = Color("BlueShadowColor")
    let green = Color("GreenColor")
    
    let card = Color("CardColor")
    let cardLayerOne = Color("CardLayer1Color")
    let cardLayerTwo = Color("CardLayer2Color")
    let cardLayerThree = Color("CardLayer3Color")
    
    let blueGradient = LinearGradient(gradient: Gradient(colors: [darkBlue, darkBlue]), startPoint: .leading, endPoint: .trailing)
    let purpleGradient = LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
    
    let text = Color("TextColor")
    let subText = Color("SubTextColor")
}
