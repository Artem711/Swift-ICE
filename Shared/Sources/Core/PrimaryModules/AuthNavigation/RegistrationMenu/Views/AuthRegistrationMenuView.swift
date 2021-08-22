//
//  AuthMenuView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct AuthRegistrationMenuView: View {
    @StateObject private var viewModel = AuthRegistrationMenuViewModel()
    
    
    var body: some View {
        AuthWrapperView(AuthRegistrationMenuStep.home) {
            ForEach(RegistrationStep.allCases) { item in
                AuthRegistrationBlockView(title: item.content.title, description: item.content.description, time: item.content.time, comlpetionStatus: self.completionStatus(item: item)) { self.viewModel.continueHandler(item: item) }
            }
            .padding(.top)

           
//            NavigationLink(
//                destination: AuthBirthDateView() { date in
//                    self.viewModel.setAdultStatus(date as? Date ?? Date())
//                    self.viewModel.showBirthDateView = false
//                    self.viewModel.navigate = true
//                }.navigationBarBackButtonHidden(true),
//                isActive: self.$viewModel.showBirthDateView) {EmptyView()}.hidden()

        }
    }
    
    
    private func completionStatus(item: RegistrationStep) -> AuthRegistrationCompletionStatus {
        let num: Int = (RegistrationStep.allCases.firstIndex(of: item) ?? 0)
        let arrayBefore = RegistrationStep.allCases[0...num]
        if self.viewModel.selectedStep == item {
            return .completing
        } else if arrayBefore.contains(self.viewModel.selectedStep) {
            return .toBeCompleted
        } else  {
            return .completed
        }
    }
}

struct AuthMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthRegistrationMenuView()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
    }
}

enum AuthRegistrationMenuStep: AuthNavigationManager {
    case home
    
    var text: (title: String, description: String) {
        switch self {
        case .home:
            return ("Home", "Home descr")
        }
    }
}

extension AuthRegistrationMenuStep {
    var id: Self {self}
}
