//
//  CloudKitchenApp.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/06/24.
//

import SwiftUI

@main
struct CloudKitchenApp: App {
    var body: some Scene {
        WindowGroup {
            getInitialeView()
        }
    }
    @ViewBuilder
    private func getInitialeView() -> some View {
        if UserDefaultsUtility.getSignedInStatus() {
            MainTabView()
        } else {
            WelcomeViewController()
        }
    }
}
