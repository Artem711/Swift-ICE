//
//  RegistrationMenuViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 14/8/21.
//

import Foundation
import Combine


enum FieldError: String {
    case tooShort = "tooShort"
    case tooLong = "tooLong"
    case empty = "empty"
    case invalid = "invalid"
    case weakPassword = "weakPassword"
    case wrongRepeatedPassword = "wrongRepeatedPassword"
    case valid = "valid"
    case silent = ""
}


final class AuthViewModel: ObservableObject {
    @Published var selectedStep: RegistrationStep = .personalData
    @Published var navigate = false
    
    @Published var dateOfBirthDone = false
    @Published var personalDataDone = false
    @Published var identificationDone = false
    @Published var investorProfileDone = false
    @Published var experienceCustomisationDone = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func subscribe(_ num: Int = 1) {
        self.cancel()
        if let move = self.authMove {
            switch move {
            case .login:
                print("login")
            case .register:
                
                self.isPhoneNumVerificationValidPublisher
                    .dropFirst()
                    .receive(on: RunLoop.main)
                    .map { value in value ? .valid : .invalid}
                    .assign(to: \.phoneNumVerificationQuestErrorText, on: self)
                    .store(in: &cancellables)
                
                
                
                self.isPasscodeCreationTooShortPublisher
                    .dropFirst()
                    .receive(on: RunLoop.main)
                    .map { value in value ?  .tooShort : .valid}
                    .assign(to: \.passcodeCreationQuestErrorText, on: self)
                    .store(in: &cancellables)
                
                
                
                self.arePasscodesEqualPublisher
                    .dropFirst()
                    .receive(on: RunLoop.main)
                    .map { value in value ? .valid : .wrongRepeatedPassword}
                    .assign(to: \.passcodeVerificationQuestErrorText, on: self)
                    .store(in: &cancellables)
                
                
            case .registerMenu:
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
        }
        else {
            self.isPhoneNumValidPublisher
                .dropFirst()
                .receive(on: RunLoop.main)
                .map { value in value == true ? .valid : .invalid}
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
    enum AuthState { case login, register, registerMenu }
    @Published var authMove: AuthState? = nil
    
    // MARK: - Quest - AuthPhoneNumQuest
    @Published var phoneNumQuestField = ""
    @Published var phoneNumQuestErrorText: FieldError = .silent
    func phoneNumQuestNext() {
        self.authMove = .register
    }
    
    private var isPhoneNumValidPublisher: AnyPublisher<Bool, Never> {
        self
            .$phoneNumQuestField
            .removeDuplicates()
            .map { $0.count >= 6 }
            .eraseToAnyPublisher()
    }
    
    // MARK: - ** LOGIN **
    // MARK: - Quest - Passcode
    
    // MARK: - ** REGISTRATION **
    // MARK: Pre-Registration Menu
    // PhoneNumVerification
    @Published var phoneNumVerificationQuestField = ""
    @Published var phoneNumVerificationQuestErrorText: FieldError = .silent
    func phoneNumVerificationQuestNext() {
    }
    func phoneNumVerificationQuestBack() {
        self.authMove = nil
    }
    private var isPhoneNumVerificationValidPublisher: AnyPublisher<Bool, Never> {
        self
            .$phoneNumVerificationQuestField
            .removeDuplicates()
            .map { $0.count < 4 }
            .eraseToAnyPublisher()
    }
    
    // PasscodeCreation
    @Published var passcodeCreationQuestField = ""
    @Published var passcodeCreationQuestErrorText: FieldError = .silent
    func passcodeCreationQuestNext() {
    }
    private var isPasscodeCreationTooShortPublisher: AnyPublisher<Bool, Never> {
        self
            .$passcodeCreationQuestField
            .removeDuplicates()
            .map { $0.count < 4 }
            .eraseToAnyPublisher()
    }
    
    // PasscodeVerification
    @Published var passcodeVerificationQuestField = ""
    @Published var passcodeVerificationQuestErrorText: FieldError = .silent
    func passcodeVerificationQuestNext() {
        self.authMove = .registerMenu
    }
    private var arePasscodesEqualPublisher: AnyPublisher<Bool, Never> {
        self.$passcodeVerificationQuestField
            .dropFirst(3)
            .combineLatest(self.$passcodeCreationQuestField)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }
    
    // MARK: Post-Registration Menu
    // MARK: - Step 0 - DateOfBirth
    @Published var dateOfBirth: Date = Date()
    var dobIsAdult: Bool {
        guard let calculatedYear = Calendar.current.dateComponents([.year], from: self.dateOfBirth, to: Date()).year, calculatedYear >= 18 else {
            return false
        }
        return true
    }
    func dateOfBirthQuestNext() {
        self.dateOfBirthDone = true
    }
    
    // MARK: - Step 1 - PersonalData (Adult)
    // - EmailField
    @Published var emailQuestField = ""
    @Published var emailQuestErrorText: FieldError = .silent
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        self.$emailQuestField
            .removeDuplicates()
            .map { $0.count > 4 }
            .eraseToAnyPublisher()
    }
    
    // - EmailVerificationField (code)
    @Published var emailVerificationQuestField = ""
    @Published var emailVerificationQuestErrorText: FieldError = .silent
    private var isEmailVerificationValidPublisher: AnyPublisher<Bool, Never> {
        self.$emailQuestField
            .removeDuplicates()
            .map { $0.count > 4 }
            .eraseToAnyPublisher()
    }
    
    // - Names
    // FirstName
    @Published var firstNameQuestField = ""
    @Published var firstNameQuestErrorText: FieldError = .silent
    private var isFirstNameEmptyPublisher: AnyPublisher<Bool, Never> {
        self.$firstNameQuestField
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    // LastName
    @Published var lastNameQuestField = ""
    @Published var lastNameQuestErrorText: FieldError = .silent
    private var isLastNameEmptyPublisher: AnyPublisher<Bool, Never> {
        self.$lastNameQuestField
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    // - Address
    // Street/number
    @Published var streetQuestField = ""
    @Published var streetQuestErrorText: FieldError = .silent
    private var isStreetEmptyPublisher: AnyPublisher<Bool, Never> {
        self.$streetQuestField
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    // Building/floor
    @Published var buildingQuestField = ""
    @Published var buildingQuestErrorText: FieldError = .silent
    private var isBuildingEmptyPublisher: AnyPublisher<Bool, Never> {
        self.$buildingQuestField
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    // Postal code
    @Published var postalCodeQuestField = ""
    @Published var postalCodeQuestErrorText: FieldError = .silent
    private var isPostalCodeValidPublisher: AnyPublisher<Bool, Never> {
        self.$postalCodeQuestField
            .removeDuplicates()
            .map { $0.count < 4 }
            .eraseToAnyPublisher()
    }
    // City
    @Published var cityQuestField = ""
    @Published var cityQuestErrorText: FieldError = .silent
    private var isCityEmptyPublisher: AnyPublisher<Bool, Never> {
        self.$cityQuestField
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    // Country
    @Published var countryQuestField = ""
    @Published var countryQuestErrorText: FieldError = .silent
    private var isCountryEmptyPublisher: AnyPublisher<Bool, Never> {
        self.$countryQuestField
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Step 1 - PersonalData (Child)
    // Parent's email
    @Published var parentEmailQuestField = ""
    @Published var parentEmailQuestErrorText: FieldError = .silent
    private var isParentEmailValidPublisher: AnyPublisher<Bool, Never> {
        self.$countryQuestField
            .removeDuplicates()
            .map { $0.count > 4 }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Step 2 - Identification
    // MARK: - Step 3 - Investor Profile
    @Published var showLongQuestions = false
    @Published var q1 = AuthInvestorProfileEnum.q1_responses[0]
    @Published var q2 = AuthInvestorProfileEnum.q2_responses[0]
    @Published var q3 = AuthInvestorProfileEnum.q3_responses[0]
    @Published var q4 = AuthInvestorProfileEnum.q4_responses[0]
    @Published var q5 = AuthInvestorProfileEnum.q5_responses[0]
    @Published var q6 = AuthInvestorProfileEnum.q6_responses[0]
    // MARK: - Step 4 - Experience Customisation
    
    
    // MARK: - ** REGISTRATION MENU LOGIC **
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
            self.navigate = true
            self.selectedStep = .personalData
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
