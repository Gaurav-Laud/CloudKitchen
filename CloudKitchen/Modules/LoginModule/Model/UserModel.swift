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
}
