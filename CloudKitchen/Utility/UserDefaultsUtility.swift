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
}
