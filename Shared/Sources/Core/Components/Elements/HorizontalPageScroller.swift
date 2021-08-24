//
//  HorizontalPageScroller.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 23/8/21.
//

import SwiftUI

struct HorizontalPageScroller<Content: View, NavigationStep: AuthNavigationManager>: View {
    typealias ContentActionHandler = (_ item: NavigationStep) -> Content
    @Binding var item: NavigationStep
    let content: ContentActionHandler
    
    var body: some View {
        TabView(selection: self.$item) {
            ForEach(NavigationStep.allCases) { item in
                self.content(item).navigationBarHidden(true)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut)
        .transition(.slide)
    }
}
