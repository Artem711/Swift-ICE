//
//  AuthViewModel.swift
//  ICE
//
//  Created by Артём Мошнин on 8/8/21.
//

import Foundation

final class AuthViewModel: ObservableObject {
    private let mode: AuthMode
    
    init(mode: AuthMode) {
        self.mode = mode
    }
}

extension AuthViewModel {
    enum AuthMode {
        case login
        case register
    }
}
