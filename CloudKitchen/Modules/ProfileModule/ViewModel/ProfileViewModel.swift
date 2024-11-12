//
//  ProfileViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 03/10/24.
//

import Foundation
enum ProfileOption: Int {
    case profileSetting
    case orderHistory
    case yourSubscription
    
    func getImage() -> String {
        switch self {
        case .profileSetting: "gearshape"
        case .orderHistory: "doc.text.magnifyingglass"
        case .yourSubscription: "doc.text.magnifyingglass"
        }
    }
    func getTitle() -> String {
        switch self {
        case .profileSetting: "Profile Settings"
        case .orderHistory: "Order History"
        case .yourSubscription: "Your Subscription"
        }
    }
    func getBackGroundColor() -> String {
        switch self {
        case .profileSetting: "#009999"
        case .orderHistory, .yourSubscription: "#417C45"
        }
    }
}
@Observable
class ProfileViewModel {
    private let sections: [ProfileOption] = [
        .profileSetting,
        .orderHistory,
        .yourSubscription
    ]
    var userModel: UserModel? = UserDefaultsUtility.getUser()
    func getOptions() -> [ProfileOption] { sections }
    func fetchUser() {
        Task { [weak self] in
            guard let self = self else { return }
            guard let id = UserDefaultsUtility.getUser()?.id else { return }
            self.userModel = try await APIHandler.shared.makeFetchAPICall(UserModel.self, url: "https://whale-app-ct2dl.ondigitalocean.app/users/\(id)")
        }
    }
}
