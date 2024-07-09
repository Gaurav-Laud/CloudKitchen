//
//  HomeView.swift
//  CloudKitchen
//
//  Created by E5000745 on 05/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                CloudTextField(inputString: $homeViewModel.searchString, image: "magnifyingglass")
                    .padding()
                List($homeViewModel.kitchenModels, id: \._id) { kitchenModel in
                    KitchenCellView(kitchenModel: kitchenModel.wrappedValue)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
                Spacer()
            }
            .toolbarRole(.navigationStack)
            .toolbar {
                getToolBarView()
            }
        }
        .navigationBarBackButtonHidden()
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
