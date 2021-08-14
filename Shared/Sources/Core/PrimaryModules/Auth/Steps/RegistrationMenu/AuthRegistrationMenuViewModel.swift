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
    { self.navigate && self.personalDataDone && self.selectedStep == .identification }
    
    var navigateToInvestorProfile: Bool
    { self.navigate && self.identificationDone && self.selectedStep == .investorProfile }
    
    var navigateToExperienceCustomisation: Bool
    { self.navigate && self.investorProfileDone && self.selectedStep == .experienceCustomisation }
    
    var navigateToEnd: Bool
    { self.navigate && self.experienceCustomisationDone && self.selectedStep == .experienceCustomisation }
}
