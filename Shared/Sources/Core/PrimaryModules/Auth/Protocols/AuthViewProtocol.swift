//
//  AuthViewProtocol.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 14/8/21.
//

import SwiftUI

protocol AuthViewProtocol: View {
    typealias ActionHandler = () -> Void
    associatedtype ViewModel: AuthViewModelProtocol
    associatedtype LocalAuthNavigation: AuthNavigationManager
    
    associatedtype V: View
    associatedtype S: View
    associatedtype D: View
    var viewModel: ViewModel { get }
    var endHandler: ActionHandler { get }
    func content(item: LocalAuthNavigation) -> V
    
    var header: S { get }
    func wrapper(currentStep: Binding<LocalAuthNavigation>) -> D
    func moveToNextScreen() -> Void
}

extension AuthViewProtocol {
    func wrapper(currentStep: Binding<LocalAuthNavigation>) -> some View {
        VStack {
            self.header
            TabView(selection: currentStep) {
                ForEach(LocalAuthNavigation.allCases) { item in
                    AuthWrapperView(item, content: {self.content(item: item)}, moveToNextScreen: self.moveToNextScreen)
                        .environmentObject(self.viewModel)
                        .tag(item)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
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
        if self.viewModel.currentStep == LocalAuthNavigation.allCases.last as! Self.ViewModel.LocalAuthNavigation { self.endHandler() } else {
            self.viewModel.moveToNextScreen()
        }
    }
}
