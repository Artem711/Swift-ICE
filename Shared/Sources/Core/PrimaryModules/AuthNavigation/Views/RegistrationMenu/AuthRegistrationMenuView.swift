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
                VStack {
                    ForEach(RegistrationStep.allCases) { item in
                        AuthRegistrationBlockView(
                            title: item.content.title,
                            description: item.content.description,
                            time: item.content.time,
                            comlpetionStatus: self.completionStatus(item: item), handler: { self.viewModel.continueHandler(item: item) }, makeChangesHandler: { self.viewModel.continueHandler(item: item.previous()) })
                    }
                }
                .offset(x: 0, y: -20)
            }, onGoBack: {_ in self.viewModel.authMove = nil})
            
            Group {
                // Step 0: Date of Birth
                NavigationLink(
                 destination: AuthDateOfBirthView(),
                    isActive: .constant(self.viewModel.navigate && self.viewModel.selectedStep == .personalData && self.viewModel.dateOfBirth == nil),
                 label: {EmptyView()})
                
                if let dob = self.viewModel.dateOfBirth, let isAdult = self.viewModel.dobIsAdult, dob != nil && isAdult {
                    // MARK: - Steps of Registration Menu
                    // Step 1: PersonalData
                    if isAdult {
                        NavigationLink(
                            destination: AuthPersonalDataQuestView(viewModel: self.viewModel),
                         isActive: .constant(self.viewModel.navigate && self.viewModel.selectedStep == .personalData),
                         label: {EmptyView()})
                    } else {
                        NavigationLink(
                         destination: AuthPersonalDataQuestView(viewModel: self.viewModel),
                         isActive: .constant(self.viewModel.navigate && self.viewModel.selectedStep == .personalData),
                         label: {EmptyView()})
                    }
                    
                    // Step 2: Identification
                    NavigationLink(
                     destination: AuthIdentificationQuestView(),
                        isActive: .constant(self.viewModel.navigateToIdentification),
                     label: {EmptyView()})
                    
                    // Step 3: InvestorProfile
                    NavigationLink(
                     destination: AuthInvestorProfileQuestView(),
                        isActive: .constant(self.viewModel.navigateToInvestorProfile),
                     label: {EmptyView()})
                    
                    // Step 4: ExperienceCustomisation
                    NavigationLink(
                     destination: AuthExperienceCustomisationQuestView(),
                        isActive: .constant(self.viewModel.navigateToExperienceCustomisation),
                     label: {EmptyView()})
                }
            }.hidden()
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
        }
    }
}


// Step 0 - DateOfBirth -- View
struct AuthDateOfBirthView: View {
    var body: some View {
        AuthWrapperView(item: AuthPersonalDataAdultEnum.self, content: { item in
            Group {
                
            }
        })
    }
}

// Step 0 - DateOfBirth -- Enum
enum AuthDateOfBirthEnum: AuthNavigationManager {
    case email, emailVerification, names, address
    var text: (title: String, description: String) {
        switch self {
        case .email:
            return ("email", "emaildesc")
        case .emailVerification:
            return ("emailVerification", "emailVerificationdesc")
        case .names:
            return ("names", "namesdesc")
        case .address:
            return ("address", "addressdesc")
        }
    }
}

extension AuthDateOfBirthEnum: Identifiable {
    var id: Self { self }
}

// Step 1 - PersonalData -- View
struct AuthPersonalDataQuestView: View {
    @ObservedObject var viewModel: AuthViewModel
    typealias LocalQuestEnum = AuthPersonalDataAdultEnum
    
    var body: some View {
        AuthWrapperView(item: LocalQuestEnum.self, content: { item in
            Group {
                switch item {
                case .email:
                    TextFieldView(placeholder: "Email",
                                  text: self.$viewModel.emailQuestField,
                                  errorText: self.viewModel.emailQuestErrorText)
                case .emailVerification:
                    TextFieldView(placeholder: "Email verification",
                                  text: self.$viewModel.emailVerificationQuestField,
                                  errorText: self.viewModel.emailVerificationQuestErrorText)
                case .names:
                    VStack {
                        TextFieldView(placeholder: "Legal first name",
                                      text: self.$viewModel.emailVerificationQuestField,
                                      errorText: self.viewModel.emailVerificationQuestErrorText)
                        
                        TextFieldView(placeholder: "Legal last name",
                                      text: self.$viewModel.emailVerificationQuestField,
                                      errorText: self.viewModel.emailVerificationQuestErrorText)
                    }
                case .address:
                    VStack {
                        TextFieldView(placeholder: "Street and number",
                                      text: self.$viewModel.streetQuestField,
                                      errorText: self.viewModel.streetQuestErrorText)
                        TextFieldView(placeholder: "Building, floor, etc.",
                                      text: self.$viewModel.buildingQuestField,
                                      errorText: self.viewModel.buildingQuestErrorText)
                        TextFieldView(placeholder: "Postal code",
                                      text: self.$viewModel.postalCodeQuestField,
                                      errorText: self.viewModel.postalCodeQuestErrorText)
                        TextFieldView(placeholder: "City",
                                      text: self.$viewModel.cityQuestField,
                                      errorText: self.viewModel.cityQuestErrorText)
                        TextFieldView(placeholder: "Country",
                                      text: self.$viewModel.countryQuestField,
                                      errorText: self.viewModel.countryQuestErrorText)
                    }
                }
            }
        }, onGoNext: {item in
            if item == LocalQuestEnum.allCases.last {
                
            }
        })
    }
}

// Step 1 - PersonalData -- Enum
enum AuthPersonalDataAdultEnum: AuthNavigationManager {
    case email, emailVerification, names, address
    var text: (title: String, description: String) {
        switch self {
        case .email:
            return ("email", "emaildesc")
        case .emailVerification:
            return ("emailVerification", "emailVerificationdesc")
        case .names:
            return ("names", "namesdesc")
        case .address:
            return ("address", "addressdesc")
        }
    }
}

extension AuthPersonalDataAdultEnum: Identifiable {
    var id: Self { self }
}

// Step 2 - Identification -- View
struct AuthIdentificationQuestView: View {
    var body: some View {
        VStack {
            Text("identification")
        }
    }
}

// Step 2 - Identification -- Enum

// Step 3 - InvestorProfile -- View
struct AuthInvestorProfileQuestView: View {
    var body: some View {
        VStack {
            Text("AuthInvestorProfile")
        }
    }
}

// Step 3 - InvestorProfile -- Enum

// Step 4 - ExperienceCustomisation -- View
struct AuthExperienceCustomisationQuestView: View {
    var body: some View {
        VStack {
            Text("AuthExperienceCustomisation")
        }
    }
}

// Step 4 - ExperienceCustomisation -- Enum

// General enum for Registration Menu
enum AuthRegistrationMenuEnum: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("Navigation", "Navigationdesc")
    }
}

extension AuthRegistrationMenuEnum: Identifiable {
    var id: Self { self }
}

