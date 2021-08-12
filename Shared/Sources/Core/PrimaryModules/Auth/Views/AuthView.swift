//
//  LoginView.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import SwiftUI
import Combine

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            self.header.padding(.horizontal)
            TabView(selection: self.$viewModel.currentStep) {
                        AuthNavigationStep.list(viewModel: self.viewModel) }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .animation(.easeInOut)
                        .transition(.slide)
        }
    }
    
    private var header: some View {
        HStack {
            Button(action: self.viewModel.moveToBackScreen, label: {
                Label("Back icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
            })
            Spacer()
            Label("Question icon", systemImage: "42.circle").labelStyle(IconOnlyLabelStyle())
        }
    }
}

extension AuthNavigationStep {
    struct IndividualAuthView: View {
        let item: AuthNavigationStep
        @EnvironmentObject private var viewModel: AuthViewModel
        
        internal init(_ item: AuthNavigationStep) {
            self.item = item
        }
        
        var body: some View {
            VStack {
                self.item.midheader()
                self.item.body(items: self.item.fields)
                self.item.footer(next: self.viewModel.moveToNextScreen)
                Spacer()
            }.padding(.horizontal)
        }
    }
    
    private func midheader() -> some View {
        VStack(alignment: .leading) {
            Text(self.text.title).titleTextStyle()
            Text(self.text.description).subtitleTextStyle()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
    }
    
    private func body(items: [FormComponent]) -> some View {
        LazyVGrid(columns: [GridItem(.flexible(minimum: 44))], spacing: 20) {
            ForEach(items) { item in
                item.view
            }
        }
    }
    
    private func footer(next: @escaping () -> ()) -> some View {
        HStack {
            Spacer()
            Button("Next", action: next)
        }
    }
    
    private func backButton(back: @escaping () -> ()) -> some View {
        Button(action: back) {
            HStack {
                Image("ic_back")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                Text("Go back")
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthView()
//            AuthView()
//                .preferredColorScheme(.dark)
        }
    }
}
