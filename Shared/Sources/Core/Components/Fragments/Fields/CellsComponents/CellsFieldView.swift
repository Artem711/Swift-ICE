//
//  CodeCellsFieldView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct CellsFieldView: View {
    let component: CellsFieldComponent
    var body: some View {
        Text("Code cells field view")
    }
}

struct CodeCellsFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CellsFieldView(component: .init())
            .previewComponent(with: "CodeCellsField View")
    }
}
