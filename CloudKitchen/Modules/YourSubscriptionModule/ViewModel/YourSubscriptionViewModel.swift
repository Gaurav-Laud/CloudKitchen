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
    var selectedSubscription: SubscriptionModel?
    func fetchSubscriptions() {
        Task { [weak self] in
            guard let self = self, let userId = UserDefaultsUtility.getUser()?.id else { return }
            do {
                self.subscriptions = try await APIHandler.shared.makeFetchAPICall([SubscriptionModel].self, url: "https://whale-app-ct2dl.ondigitalocean.app/subscriptions/user/\(userId)")
                self.convertImageUrls(for: subscriptions)
            } catch {
                print("error while fetching subscriptions: \(error)")
            }
        }
    }
    private func convertImageUrls(for subscriptions: [SubscriptionModel]) {
        subscriptions.forEach {
            $0.kitchen?.bannerImage = $0.kitchen?.bannerImage.replacingOccurrences(of: "http:", with: "https:") ?? ""
            let images = $0.kitchen?.kitchenDetailsModel?.images.map({ $0.replacingOccurrences(of: "http:", with: "https:") })
            $0.kitchen?.kitchenDetailsModel?.images = images ?? []
            $0.kitchen?.kitchenDetailsModel?.meals.forEach({
                let mealImages = $0.images.map({ $0.replacingOccurrences(of: "http:", with: "https:") })
                $0.images = mealImages
            })
        }
    }
}
