//
//  WelcomeViewController.swift
//  CloudKitchen
//
//  Created by E5000745 on 30/06/24.
//

import SwiftUI

struct WelcomeViewController: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundImage
                VStack(alignment: .center, spacing: geometry.size.height/15) {
                    titleView
                    featureStackView
                    CloudButton(title: "GET STARTED")
                }
                .padding()
                .padding(.top, geometry.size.height/5)
                .padding(.bottom, geometry.size.height/15)
            }
        }
    }
    private var backgroundImage: some View {
        Image("WelcomeBackgroundImage", bundle: Bundle.main)
            .resizable()
            .mask {
                LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(-1)]), startPoint: .top, endPoint: .bottom)
            }
    }
    private var titleView: some View {
        VStack(alignment: .center) {
            Image("hot-food1", bundle: Bundle.main)
            Text("Introducing")
                .font(.title)
            Text("Home-Made\nKitchens")
                .multilineTextAlignment(.center)
                .font(.custom("Times New Roman", size: 40))
        }
    }
    private var featureStackView: some View {
        HStack {
            Spacer()
            VStack {
                Image("Guarantee", bundle: Bundle.main)
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("High Quality")
            }
            Spacer()
            VStack {
                Image("Expensive Price", bundle: Bundle.main)
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Cost Efficient")
            }
            Spacer()
        }
    }
}

#Preview {
    WelcomeViewController()
}
