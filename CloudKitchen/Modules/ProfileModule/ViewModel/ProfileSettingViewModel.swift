//
//  ProfileSettingViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import Foundation
class ProfileSettingViewModel {
    func setProfile(userName: String, email: String) {
        guard let user = UserDefaultsUtility.getUser() else { return }
        user.name = userName
        user.email = email
        UserDefaultsUtility.setUser(user)
    }
}
