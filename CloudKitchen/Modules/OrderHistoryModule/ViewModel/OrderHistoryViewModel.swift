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
        Task {
            do {
                self.orders = try await APIHandler.shared.makeFetchAPICall([OrderModel].self, url: "https://whale-app-ct2dl.ondigitalocean.app/orders/user/\(userId)")
            } catch {
                print("error while fetching orders: \(error)")
            }
        }
    }
}
