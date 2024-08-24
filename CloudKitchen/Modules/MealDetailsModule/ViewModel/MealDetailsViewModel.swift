//
//  MealDetailsViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 29/07/24.
//

import Foundation
@Observable
class MealDetailsViewModel {
    var mealId: String = ""
    var selectedWeek: String = ""
    var kitchenModel: KitchenModel?
    var mealDetailModel: MealDetailModel?
    var weeks: [String] = []
    func fetchMealDetails(for mealId: String) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.mealDetailModel = try await APIHandler.shared.makeFetchAPICall(MealDetailModel.self, url: "https://whale-app-ct2dl.ondigitalocean.app/meals/\(mealId)")
                self.parseWeeks()
            } catch {
                print("error while fetching meal details: \(error)")
            }
        }
    }
    func parseWeeks() {
        weeks = mealDetailModel?.monthlyMenu.keys.sorted(by: { $0 < $1 }) ?? []
        selectedWeek = weeks.first ?? ""
    }
}
