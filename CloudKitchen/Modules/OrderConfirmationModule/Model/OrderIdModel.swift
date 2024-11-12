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
    var status: String
    var menuStatus: MenuStatus
    private enum CodingKeys: String, CodingKey {
        case date
        case menuItem
        case status
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        self.menuItem = try container.decodeIfPresent(MenuItemModel.self, forKey: .menuItem) ?? MenuItemModel()
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.menuStatus = MenuStatus(rawValue: status) ?? .none
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.menuItem, forKey: .menuItem)
        try container.encode(self.status, forKey: .status)
    }
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
enum MenuStatus: String {
    case none = ""
    case donated = "Donated"
    case undelivered = "Un delivered"
    case paused = "Paused"
    var title: String {
        switch self {
        case .none: ""
        case .donated: "Donated"
        case .undelivered: "Undelivered"
        case .paused: "Paused"
        }
    }
}
