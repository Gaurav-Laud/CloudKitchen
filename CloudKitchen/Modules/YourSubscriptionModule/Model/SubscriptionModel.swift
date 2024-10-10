//
//  SubscriptionModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 10/10/24.
//

import Foundation
class SubscriptionModel: Codable {
    var _id: String
    var meal: MealModel?
    var kitchen: KitchenModel?
    var user: UserModel?
    var plan: PlanModel?
    var delieveryAddress: LocationModel?
    var amount: Float
    var status: String
    var plannedDates: [String]
    var startDate: String
    var endDate: String
    var deliveryTimeSlot: String
    var pausedDates: [String]
    var donatedDates: [String]
    var deliveredDates: [String]
    var undeliveredDates: [String]
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case meal
        case kitchen
        case user
        case plan
        case delieveryAddress
        case amount
        case status
        case plannedDates
        case startDate
        case endDate
        case deliveryTimeSlot
        case pausedDates
        case donatedDates
        case deliveredDates
        case undeliveredDates
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.meal = try container.decodeIfPresent(MealModel.self, forKey: .meal)
        self.kitchen = try container.decodeIfPresent(KitchenModel.self, forKey: .kitchen)
        self.user = try container.decodeIfPresent(UserModel.self, forKey: .user)
        self.plan = try container.decodeIfPresent(PlanModel.self, forKey: .plan)
        self.delieveryAddress = try container.decodeIfPresent(LocationModel.self, forKey: .delieveryAddress)
        self.amount = try container.decodeIfPresent(Float.self, forKey: .amount) ?? 0
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.plannedDates = try container.decodeIfPresent([String].self, forKey: .plannedDates) ?? []
        self.startDate = try container.decodeIfPresent(String.self, forKey: .startDate) ?? ""
        self.endDate = try container.decodeIfPresent(String.self, forKey: .endDate) ?? ""
        self.deliveryTimeSlot = try container.decodeIfPresent(String.self, forKey: .deliveryTimeSlot) ?? ""
        self.pausedDates = try container.decodeIfPresent([String].self, forKey: .pausedDates) ?? []
        self.donatedDates = try container.decodeIfPresent([String].self, forKey: .donatedDates) ?? []
        self.deliveredDates = try container.decodeIfPresent([String].self, forKey: .deliveredDates) ?? []
        self.undeliveredDates = try container.decodeIfPresent([String].self, forKey: .undeliveredDates) ?? []
    }
}
