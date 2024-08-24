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
    
    func selectSubscription(_ type: SubscriptionType) {
        mealDetailModel?.selectedSubscriptionType = type
    }
}
