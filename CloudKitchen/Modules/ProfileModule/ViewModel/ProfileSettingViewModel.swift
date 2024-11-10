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
        let address = UserDefaultsUtility.getSelectedAddress() ?? LocationModel()
        address.fullName = userName
        UserDefaultsUtility.setUser(user)
        UserDefaultsUtility.setSelectedAddress(address)
        saveUserDetails()
    }
    func saveUserDetails() {
        guard let user = UserDefaultsUtility.getUser() else { return }
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let parameters: [String: String] = [
                    "name": user.name,
                    "email": user.email
                ]
                let userModel = try await APIHandler.shared.makePutAPICall([String: String].self,url: "https://whale-app-ct2dl.ondigitalocean.app/users/\(user.id)", parameters: parameters)
                print("user model updated successfully: \(userModel)")
            } catch {
                print("Error while updating user: \(error)")
            }
        }
    }
    func signOut() {
        CloudKitchenUtility.shared.signOut()
    }
}
