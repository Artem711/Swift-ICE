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
    
    var body: some Scene {
        WindowGroup {
            FooterNavigatorView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

typealias LabelledIcon = (name: String, icon: String)
