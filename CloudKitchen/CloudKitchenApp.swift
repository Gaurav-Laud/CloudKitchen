//
//  CloudKitchenApp.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/06/24.
//

import SwiftUI

@main
struct CloudKitchenApp: App {
    @State var rootViewManager = RootViewManager.shared
    var body: some Scene {
        WindowGroup {
            getInitialeView()
        }
    }
    @ViewBuilder
    private func getInitialeView() -> some View {
        if rootViewManager.isUserLoggedIn {
            MainTabView()
        } else {
            WelcomeViewController()
        }
    }
}
@Observable
class RootViewManager {
    static let shared = RootViewManager()
    var isUserLoggedIn: Bool
    private init() {
        isUserLoggedIn = UserDefaultsUtility.getSignedInStatus()
    }
}
