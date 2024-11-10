//
//  OrderModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import Foundation
class OrderModel: Codable {
    var _id: String
    var user: UserModel?
    var kitchen: KitchenModel?
    var meal: MealModel?
    var plan: PlanModel?
    var status: String
    var deliveryInstructions: String
    var couponCode: String
    var paymentType: String
    var savedAmount: Double
    var totalAmount: Double
    var deliveryCharges: Double
    var grandTotal: Double
    var deliveryAddress: LocationModel?
    var createdBy: String
    var updatedBy: String
    var isPaymentDone: Bool
    var deliveryTimeSlot: String
    var paymentInfo: [String: String]
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.user = try container.decodeIfPresent(UserModel.self, forKey: .user)
        self.kitchen = try container.decodeIfPresent(KitchenModel.self, forKey: .kitchen)
        self.meal = try container.decodeIfPresent(MealModel.self, forKey: .meal)
        self.plan = try container.decodeIfPresent(PlanModel.self, forKey: .plan)
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.deliveryInstructions = try container.decodeIfPresent(String.self, forKey: .deliveryInstructions) ?? ""
        self.couponCode = try container.decodeIfPresent(String.self, forKey: .couponCode) ?? ""
        self.paymentType = try container.decodeIfPresent(String.self, forKey: .paymentType) ?? ""
        self.savedAmount = try container.decodeIfPresent(Double.self, forKey: .savedAmount) ?? 0
        self.totalAmount = try container.decodeIfPresent(Double.self, forKey: .totalAmount) ?? 0
        self.deliveryCharges = try container.decodeIfPresent(Double.self, forKey: .deliveryCharges) ?? 0
        self.grandTotal = try container.decodeIfPresent(Double.self, forKey: .grandTotal) ?? 0
        if let delieveryAddress = try? container.decodeIfPresent(LocationModel.self, forKey: .deliveryAddress) {
            self.deliveryAddress = delieveryAddress
        } else if let addressString = try container.decodeIfPresent(String.self, forKey: .deliveryAddress), let data = addressString.data(using: .utf8) {
            self.deliveryAddress = try JSONDecoder().decode(LocationModel.self, from: data)
        }
        self.createdBy = try container.decodeIfPresent(String.self, forKey: .createdBy) ?? ""
        self.updatedBy = try container.decodeIfPresent(String.self, forKey: .updatedBy) ?? ""
        self.isPaymentDone = try container.decodeIfPresent(Bool.self, forKey: .isPaymentDone) ?? false
        self.deliveryTimeSlot = try container.decodeIfPresent(String.self, forKey: .deliveryTimeSlot) ?? ""
        self.paymentInfo = try container.decodeIfPresent([String : String].self, forKey: .paymentInfo) ?? [:]
    }
}
