//
//  AuthNavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

protocol AuthNavigationManager: CaseIterable, Identifiable, Hashable where AllCases: BidirectionalCollection & RandomAccessCollection {
    typealias InfoTuple = (title: String, description: String)
    var text: InfoTuple { get }
    var inquiryData: InquiryData? { get }
}

struct InquiryData {
    let image: Image
    let acceptButtonText: String
    let denyButtonText: String
}
