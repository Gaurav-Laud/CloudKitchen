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
            NavigationStack { HomeView() }
            .tabItem {
                getTabItem(title: "Order", image: Image(uiImage: UIImage(named: Constants.order_tab_image) ?? UIImage()))
            }
            NavigationStack { ProfileView() }
            .tabItem {
                getTabItem(title: "Profile", image: Image(uiImage: UIImage(named: Constants.profile_tab_image) ?? UIImage()))
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
