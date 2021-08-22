//
//  RegistrationMenuViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 14/8/21.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var selectedStep: RegistrationStep = .personalData
    @Published var navigate = false
    
    @Published var personalDataDone = false
    @Published var identificationDone = false
    @Published var investorProfileDone = false
    @Published var experienceCustomisationDone = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func subscribe() {
        if let move = self.authMove {
            switch move {
            case .login:
                print("login")
            case .register:
                switch self.selectedStep {
                case .personalData:
                    print("personalData")
                case .identification:
                    print("identification")
                case .investorProfile:
                    print("investorProfile")
                case .experienceCustomisation:
                    print("experienceCustomisation")
                }
            }
        } else {
            self.phoneNumQuestValidPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.phoneNumQuestValid, on: self)
                .store(in: &cancellables)
            
            self.phoneNumQuestValidPublisher
                .dropFirst()
                .receive(on: RunLoop.main)
                .map { _ in  "" }
                .assign(to: \.phoneNumQuestErrorText, on: self)
                .store(in: &cancellables)
        }
    }
    
    func cancel() {
        for i in cancellables {
            i.cancel()
        }
    }
    
    // MARK: - ** START SCREENS **
    enum AuthState { case login, register }
    @Published var authMove: AuthState? = nil
    
    // MARK: - Quest - AuthPhoneNumQuest
    @Published var phoneNumQuestField = ""
    @Published var phoneNumQuestErrorText = ""
    @Published var phoneNumQuestValid = false
    func phoneNumQuestNext() {
        self.authMove = .login
        self.cancel()
    }
    
    private var phoneNumQuestValidPublisher: AnyPublisher<Bool, Never> {
        self
            .$phoneNumQuestField
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 6 }
            .eraseToAnyPublisher()
    }
    
    // MARK: - ** LOGIN **
    // MARK: - Quest - Passcode
    
    // MARK: - ** REGISTRATION **
    // MARK: - Quest - dob
    @Published var dobField = Date()
    var dobIsAdult: Bool {
        if let calculatedYear = Calendar.current.dateComponents([.year], from: self.dobField, to: Date()).year, calculatedYear < 18 {
            return false
        } else {
            return true
        }
    }

    
    // MARK: - ** REGISTRATION MENU LOGIC **
    var navigateToBirthDate: Bool
    { self.navigate && self.selectedStep == .personalData && self.dobIsAdult == nil }
    
    private var navigateToPersonalData: Bool
    { self.navigate && self.selectedStep == .personalData && self.dobIsAdult != nil }
    
    var navigateToAdultPesrsonalData: Bool {
        let x = { () -> Bool in self.dobIsAdult }()
        return self.navigateToPersonalData && x
    }
    
    var navigateToChildrenPersonalData: Bool {
        let x = { () -> Bool in !self.dobIsAdult }()
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

extension AuthViewModel {
    func continueHandler(item: RegistrationStep) {
        switch item {
        case .personalData:
            print("")
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
    
    private func navigateBack() {
        self.navigate = false
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
