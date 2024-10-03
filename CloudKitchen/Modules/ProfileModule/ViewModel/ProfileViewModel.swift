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
