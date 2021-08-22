//
//  AuthMenuView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct AuthRegistrationMenuView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            AuthWrapperView(item: AuthRegistrationMenuEnum.self, content: { _ in
                ForEach(RegistrationStep.allCases) { item in
                    AuthRegistrationBlockView(title: item.content.title, description: item.content.description, time: item.content.time, comlpetionStatus: self.completionStatus(item: item)) { self.viewModel.continueHandler(item: item) }
            }}, onGoBack: {_ in self.viewModel.authMove = nil})
            
//            Group {
//               
//            }.hidden()
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
            AuthRegistrationMenuView(viewModel: AuthViewModel())
                .navigationBarHidden(true)
        }
    }
}

enum AuthRegistrationMenuEnum: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("Navigation", "Navigationdesc")
    }
}

extension AuthRegistrationMenuEnum: Identifiable {
    var id: Self { self }
}

