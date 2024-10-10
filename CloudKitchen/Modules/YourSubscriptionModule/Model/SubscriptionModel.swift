//
//  SubscriptionModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 10/10/24.
//

import Foundation
@Observable
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
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self._id, forKey: ._id)
        try container.encode(self.meal, forKey: .meal)
        try container.encode(self.kitchen, forKey: .kitchen)
        try container.encode(self.user, forKey: .user)
        try container.encode(self.plan, forKey: .plan)
        try container.encode(self.delieveryAddress, forKey: .delieveryAddress)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.plannedDates, forKey: .plannedDates)
        try container.encode(self.startDate, forKey: .startDate)
        try container.encode(self.endDate, forKey: .endDate)
        try container.encode(self.deliveryTimeSlot, forKey: .deliveryTimeSlot)
        try container.encode(self.pausedDates, forKey: .pausedDates)
        try container.encode(self.donatedDates, forKey: .donatedDates)
        try container.encode(self.deliveredDates, forKey: .deliveredDates)
        try container.encode(self.undeliveredDates, forKey: .undeliveredDates)
    }
}
