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
        case .profileSetting: "circle.fill"
        case .orderHistory: "arrow.right.circle.fill"
        case .yourSubscription: "circle.fill"
        }
    }
    func getTitle() -> String {
        switch self {
        case .profileSetting: "Profile Settings"
        case .orderHistory: "Order History"
        case .yourSubscription: "Your Subscription"
        }
    }
}
class ProfileViewModel {
    private let sections: [ProfileOption] = [
        .profileSetting,
        .orderHistory,
        .yourSubscription
    ]
    func getUserName() -> String {
        "ABD"
    }
    func getOptions() -> [ProfileOption] { sections }
}
