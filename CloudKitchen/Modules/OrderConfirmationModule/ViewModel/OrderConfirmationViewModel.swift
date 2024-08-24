//
//  OrderConfirmationViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 23/08/24.
//

import Foundation
@Observable
class OrderConfirmationViewModel {
    var kitchenModel: KitchenModel?
    var mealDetailModel: MealDetailModel?
    func getSubscriptionCost() -> Double {
        mealDetailModel?.selectedSubscriptionType == .weekly ? mealDetailModel?.weeklySubscriptionCost ?? 0.0 : mealDetailModel?.monthlySubscriptionCost ?? 0.0
    }
    func getDeliveryCost() -> Double {
        0.0
    }
    func getTotalCost() -> Double {
        getSubscriptionCost() + getDeliveryCost()
    }
    func getMealCount() -> Int {
        mealDetailModel?.selectedSubscriptionType == .weekly ? 6 : 26
    }
}
