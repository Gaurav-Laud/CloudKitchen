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
    var addresses: [LocationModel]
    var email: String
    var password: String
    var ownedKitchens: [KitchenModel]
    var image: String
    var location: LocationModel?
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case mobileNumber
        case isAppAdmin
        case isKitchenOwner
        case name
        case addresses
        case email
        case password
        case ownedKitchens
        case image
        case location
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.mobileNumber = try container.decodeIfPresent(String.self, forKey: .mobileNumber) ?? ""
        self.isAppAdmin = try container.decodeIfPresent(Bool.self, forKey: .isAppAdmin) ?? false
        self.isKitchenOwner = try container.decodeIfPresent(Bool.self, forKey: .isKitchenOwner) ?? false
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.addresses = try container.decodeIfPresent([LocationModel].self, forKey: .addresses) ?? []
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        self.ownedKitchens = try container.decodeIfPresent([KitchenModel].self, forKey: .ownedKitchens) ?? []
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        self.location = try container.decodeIfPresent(LocationModel.self, forKey: .location)
    }
}
