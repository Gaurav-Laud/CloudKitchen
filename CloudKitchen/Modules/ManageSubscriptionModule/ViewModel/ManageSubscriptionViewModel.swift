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
}
