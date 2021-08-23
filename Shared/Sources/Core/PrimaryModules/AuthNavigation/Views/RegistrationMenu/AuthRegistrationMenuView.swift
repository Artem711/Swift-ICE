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
                            comlpetionStatus: self.completionStatus(item: item), handler: { self.viewModel.continueHandler(item: item) },
                            makeChangesHandler: {
                                self.viewModel.continueHandler(item: item)
                                print(self.viewModel.selectedStep)
                            })
                    }
                }
            })
            
            Group {
                // Step 0: Date of Birth
                NavigationLink(
                    destination: AuthDateOfBirthView(viewModel: self.viewModel),
                    isActive: .constant(self.viewModel.navigate && self.viewModel.selectedStep == .personalData && self.viewModel.dateOfBirthDone == false),
                    label: {EmptyView()})
                
                
                if self.viewModel.dateOfBirthDone {
                    // MARK: - Steps of Registration Menu
                    // Step 1: PersonalData
                    if self.viewModel.dobIsAdult {
                        NavigationLink(
                            destination: AuthPersonalDataAdultQuestView(viewModel: self.viewModel).navigationBarHidden(true),
                            isActive: .constant(self.viewModel.navigate && self.viewModel.selectedStep == .personalData),
                            label: {EmptyView()})
                    } else {
                        NavigationLink(
                            destination: AuthPersonalDataChildQuestView(viewModel: self.viewModel).navigationBarHidden(true),
                            isActive: .constant(self.viewModel.navigate && self.viewModel.selectedStep == .personalData),
                            label: {EmptyView()})
                    }
                    
                    // Step 2: Identification
                    NavigationLink(
                        destination: AuthIdentificationQuestView(viewModel: self.viewModel).navigationBarHidden(true),
                        isActive: .constant(self.viewModel.navigateToIdentification),
                        label: {EmptyView()})
                    
                    // Step 3: InvestorProfile
                    NavigationLink(
                        destination: AuthInvestorProfileQuestView().navigationBarHidden(true),
                        isActive: .constant(self.viewModel.navigateToInvestorProfile),
                        label: {EmptyView()})
                    
                    // Step 4: ExperienceCustomisation
                    NavigationLink(
                        destination: AuthExperienceCustomisationQuestView(viewModel: self.viewModel).navigationBarHidden(true),
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
    @ObservedObject var viewModel: AuthViewModel
    typealias LocalQuestEnum = AuthDateOfBirthEnum

    var body: some View {
        AuthWrapperView(item: LocalQuestEnum.self, content: { item in
            DateFieldView(selectedDate: self.$viewModel.dateOfBirth, mode: [.date])
        }, onGoNext: {_ in self.viewModel.dateOfBirthQuestNext() }, onGoBack: { item in
            if item == LocalQuestEnum.allCases.first {
                self.viewModel.navigate = false
                self.viewModel.dateOfBirth = Date()
            }
        })
    }
}

// Step 0 - DateOfBirth -- Enum
enum AuthDateOfBirthEnum: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("Date of birth", "dateofbirthdesc")
    }
}

extension AuthDateOfBirthEnum: Identifiable {
    var id: Self { self }
}

// Step 1 - PersonalData (Adult) -- View
struct AuthPersonalDataAdultQuestView: View {
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
            if item == LocalQuestEnum.allCases.last { self.viewModel.doneHandler(item: .personalData) }
        }, onGoBack: {item in
            if item == LocalQuestEnum.allCases.first { self.viewModel.navigate = false }
        })
    }
}

// Step 1 - PersonalData (Adult) -- Enum
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


// Step 1 - PersonalData (Child) -- View
struct AuthPersonalDataChildQuestView: View {
    @ObservedObject var viewModel: AuthViewModel
    typealias LocalQuestEnum = AuthPersonalDataChildEnum

    var body: some View {
        AuthWrapperView(item: LocalQuestEnum.self, content: { item in
            Group {
                switch item {
                case .parentEmail:
                    TextFieldView(
                        placeholder: "",
                        text: self.$viewModel.parentEmailQuestField,
                        errorText: self.viewModel.parentEmailQuestErrorText)
                case .qrCode:
                    Text("Scan me")
                }
            }
        }, onGoNext: {item in
            if item == LocalQuestEnum.allCases.last { self.viewModel.doneHandler(item: .personalData) }
        }, onGoBack: {item in
            if item == LocalQuestEnum.allCases.first { self.viewModel.navigate = false }
        })
    }
}

// Step 1 - PersonalData (Child) -- Enum
enum AuthPersonalDataChildEnum: AuthNavigationManager {
    case parentEmail, qrCode
    var text: (title: String, description: String) {
        switch self {
        case .parentEmail:
            return ("parentEmail", "parentEmaildesc")
        case .qrCode:
            return ("qrCode", "qrCodedesc")
        }
    }
}

extension AuthPersonalDataChildEnum: Identifiable {
    var id: Self { self }
}

// Step 2 - Identification -- View
struct AuthIdentificationQuestView: View {
    @ObservedObject var viewModel: AuthViewModel
    typealias LocalQuestEnum = AuthIdentificationEnum

    var body: some View {
        AuthWrapperView(item: LocalQuestEnum.self, content: { item in
            Group {
                switch item {
                case .documentChoice:
                    Text("documentChoice")
                case .frontIdCard:
                    Text("frontIdCard")
                case .backIdCard:
                    Text("backIdCard")
                case .selfie:
                    Text("selfie")
                case .end:
                    Text("end")
                }
            }
        }, onGoNext: {item in
            if item == LocalQuestEnum.allCases.last { self.viewModel.doneHandler(item: .identification) }
        }, onGoBack: {item in
            if item == LocalQuestEnum.allCases.first { self.viewModel.navigate = false }
        })
    }
}

// Step 2 - Identification -- Enum
enum AuthIdentificationEnum: AuthNavigationManager {
    case documentChoice, frontIdCard, backIdCard, selfie, end
    var text: (title: String, description: String) {
        switch self {
        case .documentChoice:
            return ("parentEmail", "parentEmaildesc")
        case .frontIdCard:
            return ("parentEmail", "parentEmaildesc")
        case .backIdCard:
            return ("parentEmail", "parentEmaildesc")
        case .selfie:
            return ("parentEmail", "parentEmaildesc")
        case .end:
            return ("parentEmail", "parentEmaildesc")
        }
    }
}

extension AuthIdentificationEnum: Identifiable {
    var id: Self { self }
}

// Step 3 - InvestorProfile -- View
struct AuthInvestorProfileQuestView: View {
    var body: some View {
        VStack {
            Text("AuthInvestorProfile")
        }
    }
}

// Step 3 - InvestorProfile -- Enum
enum AuthInvestorProfileEnum: AuthNavigationManager {
    case start, q1, q2, q3, q4, q5, q6
    var text: (title: String, description: String) {
        switch self {
        case .start:
            return ("Let’s create your investor profile", "Please, answer 6 questions so we can tailor our recommendations and investment portfolios to you")
        case .q1:
            return ("Question 1", "When you invest money, what is your primary goal?")
        case .q2:
            return ("Question 2", "How much volatility (change in price) are you comfortable with? ")
        case .q3:
            return ("Question 3", "Which of the following is most true?")
        case .q4:
            return ("Question 4", "What is the approximate loss in any one-year period that you would be willing to accept?")
        case .q5:
            return ("Question 5", "Consider two different investments: How would you divide your investment money between them?")
        case .q6:
            return ("Question 6", """
Consider two different investments:
Investment A, which provides an average annual return of 5% with a minimal risk of loss of value,
and Investment B, which provides an average annual return of 10% and a potential loss of 25% or more in any year. How would you divide your investment money between them?
""")
        }
    }
    
    static let q1_responses: [String] = [""]
    static let q2_responses: [String] = [""]
    static let q3_responses: [String] = [""]
    static let q4_responses: [String] = [""]
    static let q5_responses: [String] = [""]
    static let q6_responses: [String] = [""]
}

extension AuthInvestorProfileEnum: Identifiable {
    var id: Self { self }
}

// Step 4 - ExperienceCustomisation -- View
struct AuthExperienceCustomisationQuestView: View {
    @ObservedObject var viewModel: AuthViewModel
    typealias LocalQuestEnum = AuthExperienceCustomisationEnum
    
    var body: some View {
        VStack {
            
        }
    }
}

// Step 4 - ExperienceCustomisation -- Enum
enum AuthExperienceCustomisationEnum: AuthNavigationManager {
    case faceId, notifications, mode
    var text: (title: String, description: String) {
        switch self {
        case .faceId:
            return ("faceId", "faceIddesc")
        case .notifications:
            return ("notifications", "notificationsdesc")
        case .mode:
            return ("mode", "modedesc")
        }
    }
}

extension AuthExperienceCustomisationEnum: Identifiable {
    var id: Self { self }
}


// General enum for Registration Menu
enum AuthRegistrationMenuEnum: AuthNavigationManager { case x
    var text: (title: String, description: String) {
        return ("Navigation", "Navigationdesc")
    }
}

extension AuthRegistrationMenuEnum: Identifiable {
    var id: Self { self }
}

