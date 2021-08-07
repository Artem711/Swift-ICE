//
//  ICEApp.swift
//  Shared
//
//  Created by Артём Мошнин on 3/8/21.
//

import SwiftUI
import Firebase

@main
struct ICEApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                FooterNavigatorView()
            } else {
                Text("LoginView")
            }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

final class AppState: ObservableObject {
    @Published private(set) var isLoggedIn = false
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        self.userService.observeAuthChanges().map{ $0 != nil }.assign(to: &self.$isLoggedIn)
    }
}

typealias LabelledIcon = (name: String, icon: String)
