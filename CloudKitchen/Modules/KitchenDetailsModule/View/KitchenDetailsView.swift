//
//  KitchenDetailsView.swift
//  CloudKitchen
//
//  Created by E5000745 on 10/07/24.
//

import SwiftUI

struct KitchenDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    private let kitchenDetailsViewModel = KitchenDetailsViewModel()
    init(kitchenModel: KitchenModel? = nil) {
        kitchenDetailsViewModel.kitchenModel = kitchenModel
    }
    var body: some View {
        Text("")
            .toolbar { getToolbarView() }
            .toolbar(.visible, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden()
    }
    @ToolbarContentBuilder
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: "chevron.left")
            })
            .tint(.black)
        }
    }
    @ViewBuilder
    private func getTopView() -> some View {
        VStack {
            
        }
        .padding()
    }
}

#Preview {
    KitchenDetailsView()
}
