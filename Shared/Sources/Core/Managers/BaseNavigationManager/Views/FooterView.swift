//
//  FooterView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 6/8/21.
//

import SwiftUI

struct FooterView: View {
    @Binding var showModal: Bool
    @Binding var selectedIndex: MainNavigator
    
    var body: some View {
        HStack {
            ForEach(MainNavigator.allCases) { item in
                Spacer()
                Button(action: {self.action(item)}) { self.content(item) }
                Spacer()
            }
        }
    }
    
    @ViewBuilder private func content(_ item: MainNavigator) -> some View {
        let isSelected = item == self.selectedIndex
        
        if item == .footerIcon {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.0431372549, green: 0.5176470588, blue: 0.9960784314, alpha: 1)), Color(#colorLiteral(red: 0.1198911294, green: 0.3413247168, blue: 0.851082027, alpha: 1))]), startPoint: .top, endPoint: .bottom)
            .frame(width: self.CENTER_ICON_SIZE, height: self.CENTER_ICON_SIZE)
            .mask(Image(systemName: item.icon).font(.system(size: self.CENTER_ICON_SIZE - 7)))
        } else {
            VStack {
                Image(systemName: item.icon)
                    .font(.system(size: self.CENTER_ICON_SIZE / 2, weight: .bold))
                    .foregroundColor(isSelected ? Color.theme.accent : .init(white: 0.8))
                
                Text(item.rawValue)
                    .font(.caption)
                    .foregroundColor(isSelected ? Color(.label) : .init(white: 0.8))
            }
        }
    }
    
    private func action(_ item: MainNavigator) {
        if (item == .footerIcon) { self.showModal.toggle()}
        else { self.selectedIndex = item}
    }
    
    
    private let CENTER_ICON_SIZE: CGFloat = 40
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(showModal: .constant(false), selectedIndex: .constant(.homeNavigation))
            .previewComponent(with: "FooterView")
    }
}
