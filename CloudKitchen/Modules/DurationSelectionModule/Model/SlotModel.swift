//
//  SlotModel.swift
//  CloudKitchen
//
//  Created by E5000745 on 01/08/24.
//

import Foundation
@Observable
class SlotModel {
    var slotNo: Int
    var startTime: String
    var endTime: String
    var isSelected: Bool
    init(slotNo: Int, startTime: String, endTime: String, isSelected: Bool) {
        self.slotNo = slotNo
        self.startTime = startTime
        self.endTime = endTime
        self.isSelected = isSelected
    }
}
