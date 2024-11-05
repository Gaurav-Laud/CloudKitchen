//
//  ManageSubscriptionViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import Foundation
@Observable
class ManageSubscriptionViewModel {
    var subscriptionModel: SubscriptionModel?
    var weeks: [String] = []
    var selectedWeek: String = ""
    var menuItemMap: [String: MenuItemModel] = [:]
    init(subscriptionModel: SubscriptionModel?) {
        self.subscriptionModel = subscriptionModel
        self.parseWeeks()
        self.mapMenuItems()
    }
    private func mapMenuItems() {
        guard let subscriptionModel = subscriptionModel else { return }
        subscriptionModel.menu.forEach { menuItemMap[$0.date] = $0.menuItem }
    }
    func getSelectedMenuItem() -> MenuItemModel {
        menuItemMap[selectedWeek] ?? MenuItemModel()
    }
    func pauseSubscription() {
        Task { [weak self] in
            guard let self = self, let subscriptionModel = self.subscriptionModel, !subscriptionModel._id.isEmpty else { return }
            let response = try await APIHandler.shared.makePutAPICall([String: String].self, url: "https://whale-app-ct2dl.ondigitalocean.app/subscriptions/\(subscriptionModel._id)/pauseSubscription")
            print("Subscription paused respose: \(response)")
        }
    }
    func donateSubscription() {
        Task { [weak self] in
            guard let self = self, let subscriptionModel = self.subscriptionModel, !subscriptionModel._id.isEmpty else { return }
            let response = try await APIHandler.shared.makePutAPICall([String: String].self, url: "https://whale-app-ct2dl.ondigitalocean.app/subscriptions/\(subscriptionModel._id)/donateMeal")
            print("Subscription doanted respose: \(response)")
        }
    }
    private func parseWeeks() {
        weeks = subscriptionModel?.menu.map({ $0.date }).sorted(by: {$0 < $1 }) ?? []
        selectedWeek = weeks.first ?? ""
    }
}
