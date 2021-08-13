//
//  InitiationAuthView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI



struct AuthStartView: View {
    private typealias LocalAuthNavigation = AuthStartStep
    
    @Binding var goToRegistration: Bool
    @StateObject private var viewModel = AuthStartViewModel()
    
    var body: some View {
        VStack {
            self.header
            TabView(selection: self.$viewModel.currentStep) {
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
    
    private func moveToNextScreen() {
        if self.viewModel.currentStep == LocalAuthNavigation.allCases.last {
            self.goToRegistration = true
            print("dskjdnsajkdsa")
        } else {
            self.viewModel.moveToNextScreen()
        }
    }
    
    @ViewBuilder private func content(item: LocalAuthNavigation) -> some View {
        switch item {
        case .phoneNumber:
            HStack {
                PhoneNumberSelectorView(countryNumbder: self.$viewModel.phoneNumberCountry)
                TextFieldView(placeholder: "Mobile number", text: self.$viewModel.phoneNumber)
            }
        case .verifyPhoneNumber:
            VStack {
                CellsFieldView()
                HStack {
                    Text("Didn't receive the code?").subtitleTextStyle()
                    Spacer()
                    Text("0:59").subtitleTextStyle()
                }
            }
        case .createPasscode:
            VStack {
                CellsFieldView()
                NumberPadView()
            }
        case .confirmPasscode:
            VStack {
                CellsFieldView()
                NumberPadView()
            }
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
        .padding(.horizontal)
    }
}

//struct AuthStartView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthStartView()
//    }
//}
