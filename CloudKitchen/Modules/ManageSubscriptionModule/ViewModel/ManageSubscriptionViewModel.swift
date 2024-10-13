//
//  ManageSubscriptionViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import Foundation
@Observable
class ManageSubscriptionViewModel {
    var subscriptionModel: SubscriptionModel
    init(subscriptionModel: SubscriptionModel) {
        self.subscriptionModel = subscriptionModel
    }
    
    func pauseSubscription() {
        Task { [weak self] in
            guard let self = self, !self.subscriptionModel._id.isEmpty else { return }
            let responce = try await APIHandler.shared.makePutAPICall([String: String].self, url: "https://whale-app-ct2dl.ondigitalocean.app/subscriptions/\(self.subscriptionModel._id)/pauseSubscription")
        }
    }
}
