//
//  AuthViewProtocol.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

protocol AuthViewProtocol: View {
    typealias ActionHandler = (_ value: Any?) -> ()
    associatedtype ViewModel: AuthViewModelProtocol
    associatedtype LocalAuthNavigation: AuthNavigationManager
    associatedtype Result: View
    
    var viewModel: ViewModel { get }
    var endHandler: ActionHandler { get }
    func content(item: LocalAuthNavigation?) -> Result
    func moveToNextScreen() -> Void
}

extension AuthViewProtocol {
    func wrapper(currentStep: Binding<LocalAuthNavigation>? = nil) -> some View {
        VStack {
            self.header
            if let step = currentStep {
                TabView(selection: step) {
                    ForEach(LocalAuthNavigation.allCases) { item in
                        AuthWrapperView(item, content: {self.content(item: item)}, moveToNextScreen: self.moveToNextScreen)
                            .tag(item)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut)
                .transition(.slide)
            } else {
                let item = LocalAuthNavigation.allCases.first!
                HStack{}
                AuthWrapperView(item, content: {self.content(item: item)})
            }
        }
    }
    
    var header: some View {
        HStack {
            Button(action: self.viewModel.moveToBackScreen, label: {
                Label("Back icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
            })
            Spacer()
            Label("Question icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
        }
        .padding(.horizontal)
    }
    
    
    
    func moveToNextScreen() {
        if self.viewModel.currentStep == LocalAuthNavigation.allCases.last as! Self.ViewModel.LocalAuthNavigation { self.endHandler(nil) } else {
            self.viewModel.moveToNextScreen()
        }
    }
}
