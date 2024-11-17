//
//  DurationSelectionViewModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 01/08/24.
//

import Foundation
@Observable
class DurationSelectionViewModel {
    var startDate: Date = Date()
    var endDate: Date = Date()
    var kitchenModel: KitchenModel?
    var mealDetailModel: MealDetailModel?
    var slotModels: [SlotModel] = [
        SlotModel(slotNo: 1, startTime: "12:30", endTime: "01:00", isSelected: true),
        SlotModel(slotNo: 2, startTime: "01:00", endTime: "01:30", isSelected: false),
        SlotModel(slotNo: 3, startTime: "01:30", endTime: "02:00", isSelected: false),
        SlotModel(slotNo: 4, startTime: "02:00", endTime: "02:30", isSelected: false)
    ]
    func setupDurationSelectionViewModel() {
        setUpInitialDates()
        if let slot = mealDetailModel?.slot { selectSlot(slot) }
    }
    func setUpInitialDates() {
        guard let mealDetailModel = mealDetailModel else { return }
        if let startDate = mealDetailModel.startDate?.convertToDate(), let endDate = mealDetailModel.endDate?.convertToDate() {
            self.startDate = startDate
            self.endDate = endDate
        } else {
            let calendar = Calendar(identifier: .iso8601)
            self.startDate = Date()
            if calendar.isDateInWeekend(startDate) {
                self.startDate = Date.getNextWeekDay(after: Date()) ?? Date()
            }
            self.endDate = calendar.date(byAdding: .day, value: mealDetailModel.selectedSubscriptionType.numberOfDays, to: startDate) ?? startDate.addingTimeInterval(TimeInterval(mealDetailModel.selectedSubscriptionType.numberOfDays * 24 * 60 * 60))
            if calendar.isDateInWeekend(endDate) {
                self.endDate = Date.getNextWeekDay(after: endDate) ?? self.endDate
            }
        }
    }
    func selectSlot(_ slot: SlotModel) {
        slotModels.forEach({ $0.isSelected = false })
        guard let index = slotModels.firstIndex(where: { $0.slotNo == slot.slotNo }) else { return }
        slotModels[index].isSelected = true
        mealDetailModel?.slot = slotModels[index]
    }
    func setStartAndEndDate() {
        mealDetailModel?.startDate = startDate.convertToString()
        mealDetailModel?.endDate = endDate.convertToString()
    }
    func validateDates() -> String? {
        guard startDate < endDate else { return "Start date should not be later than the end date." }
        let calendar = Calendar(identifier: .iso8601)
        guard !calendar.isDateInWeekend(startDate) else { return "Date cannot be a weekend." }
        guard !calendar.isDateInWeekend(endDate) else { return "Date cannot be a weekend." }
        return nil
    }
}
