//
//  HomeView.swift
//  CloudKitchen
//
//  Created by E5000745 on 05/07/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                CloudTextField(inputString: $homeViewModel.searchString, image: "magnifyingglass")
                    .padding()
                Spacer()
            }
            .toolbarRole(.navigationStack)
            .toolbar {
                getToolBarView()
            }
        }
        .onAppear(perform: { homeViewModel.fetchKitchens() })
    }
    @ToolbarContentBuilder
    private func getToolBarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading, content: {
            Image("HomeHeart", bundle: Bundle.main)
                .resizable()
                .frame(width: 31, height: 31)
        })
    }
}

#Preview {
    HomeView()
}
