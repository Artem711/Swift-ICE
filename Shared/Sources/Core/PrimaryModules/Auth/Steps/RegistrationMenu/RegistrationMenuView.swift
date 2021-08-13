//
//  AuthMenuView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

enum RegistrationStep: String, CaseIterable {
    case personalData = "Personal Data"
    case identification = "Identification"
    case investorProfile = "Create your investor Profile"
    case experienceCustomisation = "Customise your experience"
    
    var content: (title: String, time: Int, description: String) {
        switch self {
        case .personalData:
            return (self.rawValue, 2, "To safely open your account, we are required to colled this information by law. We store it with army-level, 256-bit security.")
        case .identification:
            return (self.rawValue, 2, "Verify your identity in minutes by presenting a valid document such as a passport, ID card or a driving license.")
        case .investorProfile:
            return (self.rawValue, 5, "Answer some questions so we can build your Investor Profile, understanding your needs and the risk you are willing to take.")
        case .experienceCustomisation:
            return (self.rawValue, 2, "Choose from multiple options of themes for the app, the app icon, etc. Set up your notifications as well as Face ID preferences.")
        }
    }
}

extension RegistrationStep: Identifiable {
    var id: RawValue { self.rawValue }
}

struct RegistrationMenuView: View {
    @State var selectedStep: RegistrationStep = .personalData
    
    var body: some View {
        AuthWrapperView(AuthRegistrationMenuStep.home) {
            ForEach(RegistrationStep.allCases) { item in
                AuthRegistrationBlockView(title: item.content.title, description: item.content.description, time: item.content.time, comlpetionStatus: self.completionStatus(item: item)) { self.handler(item: item) }
            }
            .padding(.top)
        }
    }
    
    private func handler(item: RegistrationStep) {
        switch item {
        case .personalData:
            self.selectedStep = self.selectedStep.next()
        case .identification:
            self.selectedStep = self.selectedStep.next()
        case .investorProfile:
            self.selectedStep = self.selectedStep.next()
        case .experienceCustomisation:
            print("Finished")
        }
    }
    
    private func completionStatus(item: RegistrationStep) -> AuthRegistrationCompletionStatus {
        let num: Int = (RegistrationStep.allCases.firstIndex(of: item) ?? 0)
        let arrayBefore = RegistrationStep.allCases[0...num]
        if self.selectedStep == item {
            return .completing
        } else if arrayBefore.contains(self.selectedStep) {
            return .toBeCompleted
        } else  {
            return .completed
        }
    }
}

struct AuthMenuView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationMenuView()
            .preferredColorScheme(.dark)
    }
}
