//
//  FormManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

protocol FormField: Identifiable {
    var id: UUID { get }
    var value: Any? { get }
}

class FormComponent: FormField {
    var id = UUID()
    var value: Any?
    
    @ViewBuilder func view(component: FormComponent) -> some View {
        switch self {
        case is DateFieldComponent:
            DateFieldView(component: component as! DateFieldComponent)
        case is CellsFieldComponent:
            CellsFieldView(component: component as! CellsFieldComponent)
        case is PasscodeCellsFieldComponent:
            PasscodeCellsFieldView(component: component as! PasscodeCellsFieldComponent)
        case is PrimaryButtonComponent:
            PrimaryButtonView(component: component as! PrimaryButtonComponent)
        default:
            EmptyView()
        }
    }
}


final class DateFieldComponent: FormComponent {
    let mode: DatePickerComponents
    init(mode: DatePickerComponents) {
        self.mode = mode
    }
}

final class CellsFieldComponent: FormComponent {
//    init() {}
}

final class PasscodeCellsFieldComponent: FormComponent {
//    init() {}
}


final class PrimaryButtonComponent: FormComponent {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    
    init(title: String,
         backgroundColor: Color = Color.theme.accent,
         foregroundColor: Color = Color.theme.text,
         borderColor: Color = .clear) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
    }
}
