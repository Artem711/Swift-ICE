//
//  ToggleButtonView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 23/8/21.
//

import SwiftUI

struct ToggleButtonView: View {
    @Binding var isOn: Bool
    let text: String
    let icon: Image
    
    var body: some View {
        HStack {
            self.icon
            Text(self.text)
            Spacer()
            Toggle(isOn: self.$isOn, label: { EmptyView() })
        }
    }
}

struct ToggleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButtonView(isOn: .constant(true), text: "Test", icon: Image(systemName: "star"))
            .previewComponent(with: "ToggleButtonView")
    }
}
