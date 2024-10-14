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
