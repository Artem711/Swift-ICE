//
//  AuthMenuView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

extension NSObject {
    func propertyNames() -> [String] {
        let mirror = Mirror(reflecting: self)
        return mirror.children.compactMap{ $0.label }
    }
}

struct AuthRegistrationMenuView: View {
    @StateObject private var viewModel = AuthRegistrationMenuViewModel()
    
    
    var body: some View {
        
        AuthWrapperView(AuthRegistrationMenuStep.home) {
            ForEach(RegistrationStep.allCases) { item in
                AuthRegistrationBlockView(title: item.content.title, description: item.content.description, time: item.content.time, comlpetionStatus: self.completionStatus(item: item)) { self.viewModel.continueHandler(item: item) }
            }
            .padding(.top)

           
            NavigationLink(
                destination: AuthBirthDateView()
                
                { date in
                    self.viewModel.setAdultStatus(date as? Date ?? Date())
                    self.viewModel.showBirthDateView = false
                    self.viewModel.navigate = true
                }.navigationBarBackButtonHidden(true),
                isActive: self.$viewModel.showBirthDateView) {EmptyView()}.hidden()

            NavigationLink(
                destination: AuthAdultPersonalDataView(endHandler: {_ in 
                    self.viewModel.doneHandler(item: .personalData)}).navigationBarBackButtonHidden(true),
                isActive: .constant(self.viewModel.navigateToAdultPesrsonalData)) {EmptyView()}.hidden()
            
            NavigationLink(
                destination: AuthChildPersonalDataView(endHandler: {_ in }).navigationBarBackButtonHidden(true),
                isActive: .constant(self.viewModel.navigateToChildrenPersonalData)) {EmptyView()}.hidden()
            
            NavigationLink(
                destination: AuthIdentificationView(registerViewModel: self.viewModel).navigationBarBackButtonHidden(true),
                isActive: .constant(self.viewModel.navigateToIdentification)) {EmptyView()}.hidden()
            
            NavigationLink(
                destination: AuthInvestorProfileView(registerViewModel: self.viewModel).navigationBarBackButtonHidden(true),
                isActive: .constant(self.viewModel.navigateToInvestorProfile)) {EmptyView()}.hidden()
            
            NavigationLink(
                destination: AuthExperienceCustomisationView(registerViewModel: self.viewModel).navigationBarBackButtonHidden(true),
                isActive: .constant(self.viewModel.navigateToExperienceCustomisation)) {EmptyView()}.hidden()
            
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
