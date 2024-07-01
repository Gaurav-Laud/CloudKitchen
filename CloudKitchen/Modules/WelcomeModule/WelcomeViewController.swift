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
                    CloudButton(title: Constants.get_started)
                }
                .padding()
                .padding(.top, geometry.size.height/5)
                .padding(.bottom, geometry.size.height/15)
            }
        }
    }
    private var backgroundImage: some View {
        Image(Constants.WelcomeBackgroundImage, bundle: Bundle.main)
            .resizable()
            .mask {
                LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(-1)]), startPoint: .top, endPoint: .bottom)
            }
    }
    private var titleView: some View {
        VStack(alignment: .center) {
            Image(Constants.hot_food1, bundle: Bundle.main)
            Text(Constants.introducing)
                .font(.title)
            Text(Constants.home_made_kitchens)
                .multilineTextAlignment(.center)
                .font(.custom(Constants.times_new_roman, size: 40))
        }
    }
    private var featureStackView: some View {
        HStack {
            Spacer()
            VStack {
                Image(Constants.guarantee, bundle: Bundle.main)
                    .resizable()
                    .frame(width: 64, height: 64)
                Text(Constants.high_quality)
            }
            Spacer()
            VStack {
                Image(Constants.expensive_price, bundle: Bundle.main)
                    .resizable()
                    .frame(width: 64, height: 64)
                Text(Constants.cost_efficient)
            }
            Spacer()
        }
    }
}

#Preview {
    WelcomeViewController()
}
