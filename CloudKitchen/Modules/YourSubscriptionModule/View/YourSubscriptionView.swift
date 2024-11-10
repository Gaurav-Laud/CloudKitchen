//
//  YourSubscriptionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import SwiftUI

struct YourSubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var showManageSubscriptionView: Bool = false
    @State var yourSubscriptionViewModel = YourSubscriptionViewModel()
    var body: some View {
        List(yourSubscriptionViewModel.subscriptions, id: \._id) { subscription in
            self.getSubscriptionCell(for: subscription)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .listStyle(.inset)
//        .padding()
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showManageSubscriptionView, destination: { ManageSubscriptionView(subscriptionModel: self.yourSubscriptionViewModel.selectedSubscription) })
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
        ToolbarItem(placement: .topBarLeading) {
            CloudLabel(text: "Your Subscription", font: .title2)
        }
    }
    @ViewBuilder
    private func getSubscriptionCell(for subscription: SubscriptionModel) -> some View {
        SubscriptionView(showManageButton: true, subscription: subscription, delegate: self)
    }
}
extension YourSubscriptionView: SubscriptionViewDelegate {
    func manageButtonClicked(subscription: SubscriptionModel) {
        self.yourSubscriptionViewModel.selectedSubscription = subscription
        self.showManageSubscriptionView = true
    }
}

#Preview {
    YourSubscriptionView()
}
