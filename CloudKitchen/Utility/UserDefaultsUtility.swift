//
//  UserDefaults.swift
//  CloudKitchen
//
//  Created by E5000745 on 01/07/24.
//

import Foundation
class UserDefaultsUtility {
    static let defaults = UserDefaults.standard
    static func setSignedInStatus(_ flag: Bool) {
        defaults.setValue(flag, forKey: Constants.isSignedIn)
    }
    static func getSignedInStatus() -> Bool {
        defaults.bool(forKey: Constants.isSignedIn)
    }
    static func setAccessToken(_ accessToken: String) {
        defaults.setValue(accessToken, forKey: Constants.accessToken)
    }
    static func getAccessToken() -> String {
        defaults.string(forKey: Constants.accessToken) ?? ""
    }
    static func setUser(_ userModel: UserModel) {
        guard let data = try? JSONEncoder().encode(userModel) else { return }
        defaults.setValue(data, forKey: Constants.userModel)
    }
    static func getUser() -> UserModel? {
        guard let data = defaults.value(forKey: Constants.userModel) as? Data else { return nil }
        return try? JSONDecoder().decode(UserModel.self, from: data)
    }
    static func setSelectedAddress(_ address: LocationModel) {
        guard let data = try? JSONEncoder().encode(address) else { return }
        defaults.setValue(data, forKey: Constants.selectedAddress)
    }
    static func getSelectedAddress() -> LocationModel? {
        guard let data = defaults.value(forKey: Constants.selectedAddress) as? Data else { return nil }
        return try? JSONDecoder().decode(LocationModel.self, from: data)
    }
}
