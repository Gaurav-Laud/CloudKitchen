//
//  UserModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 05/07/24.
//

import Foundation
class UserModel: Codable {
    var id: String
    var mobileNumber: String
    var isAppAdmin: Bool
    var isKitchenOwner: Bool
    var name: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.mobileNumber = try container.decodeIfPresent(String.self, forKey: .mobileNumber) ?? ""
        self.isAppAdmin = try container.decodeIfPresent(Bool.self, forKey: .isAppAdmin) ?? false
        self.isKitchenOwner = try container.decodeIfPresent(Bool.self, forKey: .isKitchenOwner) ?? false
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
