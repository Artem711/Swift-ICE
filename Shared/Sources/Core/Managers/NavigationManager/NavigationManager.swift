//
//  NavigationManager.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 3/8/21.
//

import SwiftUI

enum MainNavigator: String, CaseIterable {
    case homeNavigation = "Home"
    case investingNavigation = "Investing"
    case footerIcon = ""
    case socialNavigation = "Social"
    case academyNavigation = "Academy"
    
    var icon: String {
        switch self {
        case .investingNavigation:
            return "person.fill"
        case .socialNavigation:
            return "person.fill"
        case .academyNavigation:
            return "person.fill"
        case .footerIcon:
            return "plus.app.fill"
        default:
            return "person.fill"
        }
    }
    
    static var views: some View {
        ForEach(Self.cleanCases()) { item in
            item.view.tag(item)
        }
    }
    
    static private func cleanCases() -> [MainNavigator] {
        self.allCases.filter { (item) -> Bool in
            item != .footerIcon
        }
    }
    
    @ViewBuilder private var view: some View {
        switch self {
        case .investingNavigation: self.generator(navigator: InvestingNavigation.self)
        case .socialNavigation: self.generator(navigator: SocialNavigation.self)
        case .academyNavigation: self.generator(navigator: AcademyNavigation.self)
        default: self.generator(navigator: HomeNavigation.self)
        }
    }
    
    func generator<T: ModuleNavigator>(navigator: T.Type) -> some View where T.AllCases: RandomAccessCollection, T.RawValue: StringProtocol {
        ModuleWrapper(navigator: navigator.self) {
            ForEach(navigator.allCases) { item in item.previewView.tag(item) }
        }
    }
}

extension MainNavigator: Identifiable {
    var id: RawValue { self.rawValue }
}

protocol ModuleNavigator: CaseIterable & RawRepresentable & Hashable & Identifiable {
    associatedtype V: View
    var icon: String { get }
    var previewData: SectionPreviewData { get }
    var view: V { get }
}

extension ModuleNavigator {
    var previewView: some View { ModuleDistributorView(navigator: self.self) }
    var enumTitle: String {
        switch self {
        case is InvestingNavigation:
            return "Investing"
        case is SocialNavigation:
            return  "Social"
        case is AcademyNavigation:
            return "Academy"
        default:
            return "Home"
        }
    }
    
}

enum HomeNavigation: String, ModuleNavigator {
    case overview = "Overview"
    case custodial = "Custodial"
    case impact = "Impact"
    case card = "Card"
    
    @ViewBuilder var view: some View {
        switch self {
        case .custodial: Text(self.rawValue)
        case .impact: Text(self.rawValue)
        case .card: Text(self.rawValue)
        default: Text(self.rawValue)
        }
    }
    
    var icon: String {
        switch self {
        case .overview:
            return "star"
        case .custodial:
            return "star"
        case .impact:
            return "star"
        case .card:
            return "star"
        }
    }
    
    var previewData: SectionPreviewData {
        switch self {
        case .overview:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .custodial:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .impact:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .card:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        }
    }
}

extension HomeNavigation: Identifiable {
    var id: RawValue { self.rawValue }
}

enum InvestingNavigation: String, ModuleNavigator {
    case youInvest = "You invest"
    case weInvestForYou = "We invest for you"
    case smartRules = "Smart rules"
    
    @ViewBuilder var view: some View {
        switch self {
        case .weInvestForYou: Text(self.rawValue)
        case .smartRules: Text(self.rawValue)
        default: Text(self.rawValue)
        }
    }
    
    var icon: String {
        switch self {
        case .youInvest:
            return "star"
        case .weInvestForYou:
            return "star"
        case .smartRules:
            return "star"
        }
    }
    
    var previewData: SectionPreviewData {
        switch self {
        case .youInvest:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .weInvestForYou:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .smartRules:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        }
    }
}

extension InvestingNavigation: Identifiable {
    var id: RawValue { self.rawValue }
}

enum SocialNavigation: String, ModuleNavigator {
    case feed = "Feed"
    case groups = "Groups"
    case themes = "Themes"
    case investors = "Investors"
    
    @ViewBuilder var view: some View {
        switch self {
        case .groups: self.previewView
        case .themes: Text(self.rawValue)
        case .investors: Text(self.rawValue)
        default: Text(self.rawValue)
        }
    }
    
    var icon: String {
        switch self {
        case .feed:
            return "star"
        case .groups:
            return "star"
        case .themes:
            return "star"
        case .investors:
            return "star"
        }
    }
    
    var previewData: SectionPreviewData {
        switch self {
        case .feed:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .groups:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .themes:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .investors:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        }
    }
}

extension SocialNavigation: Identifiable {
    var id: RawValue { self.rawValue }
}

enum AcademyNavigation: String, ModuleNavigator {
    case courses = "Courses"
    case missions = "Missions"
    case games = "Games"
    case blog = "Blog"
    
    @ViewBuilder var view: some View {
        switch self {
        case .missions: Text(self.rawValue)
        case .games: Text(self.rawValue)
        case .blog: Text(self.rawValue)
        default: Text(self.rawValue)
        }
    }
    
    var icon: String {
        switch self {
        case .courses:
            return "star"
        case .missions:
            return "star"
        case .games:
            return "star"
        case .blog:
            return "star"
        }
    }
    
    var previewData: SectionPreviewData {
        switch self {
        case .courses:
            return (title: "Courses investing", description: "Invest completely automatically", image: "person")
        case .missions:
            return (title: "Missions investing", description: "Invest completely automatically", image: "person")
        case .games:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        case .blog:
            return (title: "Auto investing", description: "Invest completely automatically", image: "person")
        }
    }
}

typealias SectionPreviewData = (title: String, description: String, image: String)

extension AcademyNavigation: Identifiable {
    var id: RawValue { self.rawValue }
}

struct ModuleDistributorView<T: ModuleNavigator>: View {
    @AppStorage var hasInitiatedSection: Bool
    let navigator: T
    let userDefaultsIdentifier: String
    
    init(navigator: T) {
        self.navigator = navigator
        let userDefaultsIdentifier = "\(navigator.enumTitle)-\(navigator.rawValue)"
        self.userDefaultsIdentifier = userDefaultsIdentifier
        self._hasInitiatedSection = AppStorage(wrappedValue: false, userDefaultsIdentifier)
    }
    
    var body: some View {
        if self.hasInitiatedSection {
            Text("Hello")
        } else {
            StarterRectangleView(data: self.navigator.previewData, userDefaultsIdentifier:  self.userDefaultsIdentifier)
        }
    }
}

struct ModuleDistributorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //            SectionPreviewView()
            ModuleDistributorView(navigator: HomeNavigation.overview)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}
