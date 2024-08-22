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
    var slotModels: [SlotModel] = [
        SlotModel(slotNo: 1, startTime: "12:30", endTime: "01:00", isSelected: true),
        SlotModel(slotNo: 2, startTime: "01:00", endTime: "01:30", isSelected: false),
        SlotModel(slotNo: 3, startTime: "01:30", endTime: "02:00", isSelected: false),
        SlotModel(slotNo: 4, startTime: "02:00", endTime: "02:30", isSelected: false)
    ]
    func selectSlot(_ slot: SlotModel) {
        guard let index = slotModels.firstIndex(where: { $0.slotNo == slot.slotNo }) else { return }
        slotModels[index].isSelected = true
    }
}
