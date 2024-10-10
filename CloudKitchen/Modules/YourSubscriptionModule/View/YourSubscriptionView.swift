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
        List(yourSubscriptionViewModel.subscriptions, id: \._id) { subscription in
            self.getSubscriptionCell(for: subscription)
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
    private func getSubscriptionCell(for subscription: SubscriptionModel) -> some View {
        SubscriptionView(showManageButton: true, subscription: subscription)
    }
}

#Preview {
    YourSubscriptionView()
}
