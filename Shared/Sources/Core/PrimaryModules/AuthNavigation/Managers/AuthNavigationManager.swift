//
//  AuthNavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

protocol AuthNavigationManager: CaseIterable, Identifiable, Hashable where AllCases: BidirectionalCollection & RandomAccessCollection {
    var text: (title: String, description: String, image: Image?, acceptButtonText: String?, denyButtonText: String?) { get }
}
