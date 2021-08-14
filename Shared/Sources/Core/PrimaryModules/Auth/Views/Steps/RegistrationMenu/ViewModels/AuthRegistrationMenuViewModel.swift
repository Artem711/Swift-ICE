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
    
    @Published var isAdult: Bool? = nil
    @Published var showBirthDateView: Bool = false
    
    @Published var personalDataDone = false
    @Published var identificationDone = false
    @Published var investorProfileDone = false
    @Published var experienceCustomisationDone = false
    
    var navigateToBirthDate: Bool
    { self.navigate && self.selectedStep == .personalData && self.isAdult == nil }
    
    private var navigateToPersonalData: Bool
    { self.navigate && self.selectedStep == .personalData && self.isAdult != nil }
    
    var navigateToAdultPesrsonalData: Bool {
        let x = { () -> Bool in if let isAdult = self.isAdult { return isAdult } else { return false }}()
        return self.navigateToPersonalData && x
    }
    
    var navigateToChildrenPersonalData: Bool {
        let x = { () -> Bool in if let isAdult = self.isAdult { return !isAdult } else { return false }}()
        return self.navigateToPersonalData && x
    }
    
    var navigateToIdentification: Bool
    { self.navigate && self.selectedStep == .identification }
    
    var navigateToInvestorProfile: Bool
    { self.navigate && self.selectedStep == .investorProfile }
    
    var navigateToExperienceCustomisation: Bool
    { self.navigate && self.selectedStep == .experienceCustomisation }
    
    var navigateToEnd: Bool
    { self.navigate && self.experienceCustomisationDone && self.selectedStep == .experienceCustomisation }
}

extension AuthRegistrationMenuViewModel {
    func continueHandler(item: RegistrationStep) {
        switch item {
        case .personalData:
            if self.isAdult != nil {
                self.selectedStep = .personalData
                self.navigate = true
            } else { self.showBirthDateView = true }
        case .identification:
            if self.personalDataDone {
                self.selectedStep = .identification
                self.navigate = true
            }
        case .investorProfile:
            if self.identificationDone {
                self.selectedStep = .investorProfile
                self.navigate = true
            }
        case .experienceCustomisation:
            if self.investorProfileDone {
                self.selectedStep = .experienceCustomisation
                self.navigate = true
            }
        }
    }
    
    func doneHandler(item: RegistrationStep) {
        switch item {
        case .personalData:
            self.personalDataDone = true
            self.navigateBack()
            self.selectedStep = .identification
        case .identification:
            self.identificationDone = true
            self.navigateBack()
            self.selectedStep = .investorProfile
        case .investorProfile:
            self.investorProfileDone = true
            self.navigateBack()
            self.selectedStep = .experienceCustomisation
        case .experienceCustomisation:
            self.experienceCustomisationDone = true
        }
    }
    
    private func navigateBack() {self.navigate = false}
    func setAdultStatus(_ date: Date) {
        if let calculatedYear = Calendar.current.dateComponents([.year], from: date, to: Date()).year, calculatedYear < 18 {
            self.isAdult = false
        } else {
                self.isAdult = true
            }
        }
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
