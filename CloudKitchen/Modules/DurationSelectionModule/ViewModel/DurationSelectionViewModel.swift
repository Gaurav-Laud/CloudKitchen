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
    var slotModels: [SlotModel] = [SlotModel(slotNo: 1, startTime: "12:00", endTime: "2:00", isSelected: true)]
    func selectSlot(_ slot: SlotModel) {
        guard let index = slotModels.firstIndex(where: { $0.slotNo == slot.slotNo }) else { return }
        slotModels[index].isSelected = true
    }
}
