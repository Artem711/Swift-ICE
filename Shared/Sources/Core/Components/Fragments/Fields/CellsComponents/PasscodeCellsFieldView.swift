//
//  PasscodeCellsFieldView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct PasscodeCellsFieldView: View {
    let component: PasscodeCellsFieldComponent
    var body: some View {
        Text("PasscodeCellsField View")
    }
}

struct PasscodeCellsFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeCellsFieldView(component: .init())
            .previewComponent(with: "PasscodeCellsField view")
    }
}
