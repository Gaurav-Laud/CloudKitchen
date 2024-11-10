//
//  OrderHistoryViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import Foundation
@Observable
class OrderHistoryViewModel {
    var orders: [OrderModel] = []
    
    func fetchOrders() {
        guard let userId = UserDefaultsUtility.getUser()?.id else { return }
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.orders = try await APIHandler.shared.makeFetchAPICall([OrderModel].self, url: "https://whale-app-ct2dl.ondigitalocean.app/orders/user/\(userId)")
                self.convertImageUrls(for: orders)
            } catch {
                print("error while fetching orders: \(error)")
            }
        }
    }
    private func convertImageUrls(for orders: [OrderModel]) {
        orders.forEach {
            $0.kitchen?.bannerImage = $0.kitchen?.bannerImage.replacingOccurrences(of: "http:", with: "https:") ?? ""
            $0.meal?.bannerImage = $0.meal?.bannerImage.replacingOccurrences(of: "http:", with: "https:") ?? ""
            let images = $0.kitchen?.kitchenDetailsModel?.images.map({ $0.replacingOccurrences(of: "http:", with: "https:") })
            $0.kitchen?.kitchenDetailsModel?.images = images ?? []
            $0.kitchen?.kitchenDetailsModel?.meals.forEach({
                let mealImages = $0.images.map({ $0.replacingOccurrences(of: "http:", with: "https:") })
                $0.images = mealImages
            })
        }
    }
}
