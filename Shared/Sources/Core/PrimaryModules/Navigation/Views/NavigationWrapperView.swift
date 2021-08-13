//
//  PrimaryModuleWrapper.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 3/8/21.
//

import SwiftUI

struct NavigationWrapperView<T: ModuleNavigator, Content: View>: View where T.AllCases: RandomAccessCollection, T.RawValue: StringProtocol {
    let navigator: T.Type
    let content: Content
    @State private var selectedView = T.allCases.first!
    
    init(navigator: T.Type, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.navigator = navigator
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                // Content layer
                GeometryReader { proxy in
                    ScrollView {
                        ScrollerView(items: self.navigator.self, selectedView: self.$selectedView)
                        TabView(selection: self.$selectedView) {
                            self.content
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
            }.navigationBarTitle(self.screenTitle)
        }.accentColor(Color.theme.text)
    }
    
    private var screenTitle: String {
        switch self.navigator {
        case is HomeNavigation.Type:
            return "Home"
        case is InvestingNavigation.Type:
            return "Investing"
        case is SocialNavigation.Type:
            return "Social"
        case is AcademyNavigation.Type:
            return "Academy"
        default:
            return "Default"
        }
    }
}

struct ModuleWrapper_Previews: PreviewProvider {
    static var previews: some View {
            NavigationWrapperView(navigator: HomeNavigation.self) {Text("Test")}.preferredColorScheme(.dark)
    }
}
