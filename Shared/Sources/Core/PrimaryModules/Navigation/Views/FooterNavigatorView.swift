//
//  TabNavigatorView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 3/8/21.
//

import SwiftUI

typealias LocalMainNavigator = MainNavigator
struct FooterNavigatorView: View {
    @State private var showModal = false
    @State private var selectedIndex: LocalMainNavigator = .homeNavigation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            TabView(selection: self.$selectedIndex) { LocalMainNavigator.views }
            FooterView(showModal: self.$showModal, selectedIndex: self.$selectedIndex)
        }
        .sheet(isPresented: self.$showModal) { Text("Modal hello") }
    }
}

struct FooterNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            TabNavigatorView()
            FooterNavigatorView()
                .preferredColorScheme(.dark)
        }
    }
}
