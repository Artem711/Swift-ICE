//
//  Header.swift
//  ICE
//
//  Created by Артём Мошнин on 4/8/21.
//

import SwiftUI

struct HeaderViewModifier<T: ModuleNavigator>: ViewModifier {
    let navigator: T.Type
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    self.iconButton(label: "Save", icon: self.customHeaderIcon(navigator: navigator)) {
                        print("Hello")
                    }
                    self.iconButton(label: "Save", icon: "square.and.arrow.down") {
                        print("Hello")
                    }
                    self.iconButton(label: "Save", icon: "square.and.arrow.down") {
                        print("Hello")
                    }
                }
            }
        }
    }
    
    private func customHeaderIcon<T: ModuleNavigator>(navigator: T.Type) -> String {
        switch navigator {
        case is InvestingNavigation.Type:
            return "star"
        case is SocialNavigation.Type:
            return "star"
        case is AcademyNavigation.Type:
            return "star"
        default:
            return "star"
        }
    }
    
    private func iconButton(label: String, icon: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Label(label, systemImage: icon)
                .font(.title3)
                .padding(.horizontal, 6)
        }
    }
}

extension View {
    func header<T: ModuleNavigator>(navigator: T.Type) -> some View {
        self.modifier(HeaderViewModifier(navigator: navigator))
    }
}
