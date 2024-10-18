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
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.user = try container.decode(UserModel.self, forKey: .user)
        self.kitchen = try container.decode(KitchenModel.self, forKey: .kitchen)
        self.meal = try container.decode(MealModel.self, forKey: .meal)
        self.plan = try container.decode(PlanModel.self, forKey: .plan)
        self.status = try container.decode(String.self, forKey: .status)
        self.deliveryInstructions = try container.decode(String.self, forKey: .deliveryInstructions)
        self.couponCode = try container.decode(String.self, forKey: .couponCode)
        self.paymentType = try container.decode(String.self, forKey: .paymentType)
        self.savedAmount = try container.decode(Double.self, forKey: .savedAmount)
        self.totalAmount = try container.decode(Double.self, forKey: .totalAmount)
        self.deliveryCharges = try container.decode(Double.self, forKey: .deliveryCharges)
        self.grandTotal = try container.decode(Double.self, forKey: .grandTotal)
        self.deliveryAddress = try container.decode(LocationModel.self, forKey: .deliveryAddress)
        self.createdBy = try container.decode(String.self, forKey: .createdBy)
        self.updatedBy = try container.decode(String.self, forKey: .updatedBy)
        self.isPaymentDone = try container.decode(Bool.self, forKey: .isPaymentDone)
        self.deliveryTimeSlot = try container.decode(String.self, forKey: .deliveryTimeSlot)
        self.paymentInfo = try container.decode([String : String].self, forKey: .paymentInfo)
    }
}
