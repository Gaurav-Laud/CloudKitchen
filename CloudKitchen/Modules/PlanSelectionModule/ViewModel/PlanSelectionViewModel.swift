//
//  PlanSelectionViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 04/08/24.
//

import Foundation
@Observable
class PlanSelectionViewModel {
    var kitchenModel: KitchenModel?
    var mealDetailModel: MealDetailModel?
    
    func selectSubscription(_ type: String) {
        guard let subscriptionModel = SubscriptionType(rawValue: type) else { return }
        mealDetailModel?.selectedSubscriptionType = subscriptionModel
        kitchenModel?.kitchenDetailsModel?.availablePlans.forEach({ $0.isSelected = $0.type == type })
    }
    func getSubscriptionCost(for type: String) -> Double? {
        var cost: Double? = nil
        guard let subscriptionType = SubscriptionType(rawValue: type) else { return cost }
        switch subscriptionType {
        case .weekly:
            cost = mealDetailModel?.weeklySubscriptionCost
        case .monthly:
            cost = mealDetailModel?.monthlySubscriptionCost
        }
        return cost
    }
}
