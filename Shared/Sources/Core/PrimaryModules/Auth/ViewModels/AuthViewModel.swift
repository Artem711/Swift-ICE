//
//  AuthViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import Foundation

final class AuthViewModel: ObservableObject {
    private let ageLimit = 18
    
    @Published var password = ""
    @Published var email = ""
    @Published var firstName = ""
    @Published var lastName = ""
    
    // Address
    @Published var street = ""
    @Published var building = ""
    @Published var postalCode = ""
    @Published var city = ""
    @Published var country = ""
    
    @Published var isValid = false
    
    @Published private(set) var dateOfBirth = Date()
    @Published private(set) var isAdult = false
    
    func setDateOfBirth(date: Date) {
        self.dateOfBirth = date
        if let calculatedYear = Calendar.current.dateComponents([.year], from: date, to: Date()).year, calculatedYear < self.ageLimit {
            self.isAdult = false
            return
        }
        self.isAdult = true
    }
}
