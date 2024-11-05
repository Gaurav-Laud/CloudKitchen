//
//  OrderIdModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import Foundation
class OrderIdModel: Codable {
    var amount: Int
    var amount_due: Int
    var amount_paid: Int
    var attempts: Int
    var created_at: Double
    var currency: String
    var entity: String
    var id: String
    var notes: [String: String]
    var offer_id: String?
    var receipt: String
    var status: String
}
class ReviewOrderModel: Codable {
    var totalAmount: Double
    var plannedDates: [PlannedDates]
    var discount: String
    var grandTotal: Double
    var savedAmount: Double
    var walletAmount: Double
}
class PlannedDates: Codable {
    var date: String
    var menuItem: MenuItemModel
}
enum RadioButtonOption: String, CaseIterable, Identifiable {
    case yes
    case no
    var id: RawValue {
        rawValue
    }
    var title: String {
        switch self {
        case .yes: "Yes"
        case .no: "No"
        }
    }
}
