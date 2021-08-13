//
//  CountryPhoneCode.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 13/8/21.
//

import Foundation

enum CountryPhoneCode: Int, CaseIterable {
    case spain = 34
    case russia = 7
}

extension CountryPhoneCode: Identifiable {
    var id: Int { self.rawValue }
}
