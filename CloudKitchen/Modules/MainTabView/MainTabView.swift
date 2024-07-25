//
//  MainTabView.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/07/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView() {
            HomeView()
                .tabItem {
                    Label("Order", image: ImageResource(name: Constants.order_tab_image, bundle: Bundle.main))
                }
            WelcomeViewController()
                .tabItem {
                    Label("Profile", image: ImageResource(name: Constants.profile_tab_image, bundle: Bundle.main))
                }
        }
        .tint(.yellow)
        .navigationBarBackButtonHidden()
    }
    @ViewBuilder
    private func getTabItem(title: String, image: Image, tintColour: Color? = nil) -> some View {
        VStack {
            image
            CloudLabel(text: title, textColor: .yellow)
        }
    }
}

#Preview {
    MainTabView()
}
