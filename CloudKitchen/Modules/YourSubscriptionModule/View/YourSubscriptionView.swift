//
//  YourSubscriptionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import SwiftUI

struct YourSubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var yourSubscriptionViewModel = YourSubscriptionViewModel()
    var body: some View {
        VStack {
            self.getSubscriptionCell()
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
            self.getToolbarView()
        }
        .onAppear{ self.yourSubscriptionViewModel.fetchSubscriptions() }
    }
    @ToolbarContentBuilder
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: Constants.chevron_left)
            })
            .tint(.black)
        }
    }
    @ViewBuilder
    private func getSubscriptionCell() -> some View {
        SubscriptionView(showManageButton: true)
    }
}

#Preview {
    YourSubscriptionView()
}
