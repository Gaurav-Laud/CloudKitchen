//
//  YourSubscriptionViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import Foundation
@Observable
class YourSubscriptionViewModel {
    var subscriptions: [SubscriptionModel] = []
    func fetchSubscriptions() {
        Task { [weak self] in
            guard let self = self, let userId = UserDefaultsUtility.getUser()?.id else { return }
            do {
                self.subscriptions = try await APIHandler.shared.makeFetchAPICall([SubscriptionModel].self, url: "https://whale-app-ct2dl.ondigitalocean.app/subscriptions/user/\(userId)")
            } catch {
                print("error while fetching subscriptions: \(error)")
            }
        }
    }
}
