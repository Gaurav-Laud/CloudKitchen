//
//  OrderModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import Foundation
class OrderModel: Codable {
    var _id: String
    var user: UserModel
    var kitchen: KitchenModel
    var meal: MealModel
    var plan: PlanModel
    var status: String
    var deliveryInstructions: String
    var couponCode: String
    var paymentType: String
    var savedAmount: Double
    var totalAmount: Double
    var deliveryCharges: Double
    var grandTotal: Double
    var deliveryAddress: LocationModel
    var createdBy: String
    var updatedBy: String
    var isPaymentDone: Bool
    var deliveryTimeSlot: String
    var paymentInfo: [String: String]
}
