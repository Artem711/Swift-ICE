//
//  RegistrationMenuViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 14/8/21.
//

import Foundation

final class AuthRegistrationMenuViewModel: ObservableObject {
    @Published var selectedStep: RegistrationStep = .personalData
    @Published var navigate = false
    
    @Published var personalDataDone = false
    @Published var identificationDone = false
    @Published var investorProfileDone = false
    @Published var experienceCustomisationDone = false
    
    var navigateToPersonalData: Bool
    { self.navigate && self.selectedStep == .personalData }
    
    var navigateToIdentification: Bool
    { self.navigate && self.selectedStep == .identification }
    
    var navigateToInvestorProfile: Bool
    { self.navigate && self.selectedStep == .investorProfile }
    
    var navigateToExperienceCustomisation: Bool
    { self.navigate && self.selectedStep == .experienceCustomisation }
    
    var navigateToEnd: Bool
    { self.navigate && self.selectedStep == .experienceCustomisation }
    
    func handler(item: RegistrationStep) {
        switch item {
        case .personalData:
            if self.personalDataDone {
                self.selectedStep = .personalData
                self.navigate = true
            }
        case .identification:
            if self.identificationDone {
                self.selectedStep = .investorProfile
                self.navigate = true
            }
        case .investorProfile:
            if self.investorProfileDone {
                self.selectedStep = .experienceCustomisation
                self.navigate = true
            }
        case .experienceCustomisation:
            if self.experienceCustomisationDone {
                self.navigate = true
            }
        }
    }
    
    // MARK: - PersonalData
    @Published var dobText = ""
    @Published var emailText = ""
    @Published var emailVerificationText = ""
    @Published var firstNameText = ""
    @Published var lastNameText = ""
    @Published var streetText = ""
    @Published var buildingText = ""
    @Published var postalCodeText = ""
    @Published var cityText = ""
    @Published var countryText = ""
}

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
