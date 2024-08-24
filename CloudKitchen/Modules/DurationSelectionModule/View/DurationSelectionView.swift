//
//  DurationSelectionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 31/07/24.
//

import SwiftUI

struct DurationSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var durationSelectionViewModel = DurationSelectionViewModel()
    @State var showOrderView = false
    init(kitchenModel: KitchenModel?, mealDetailModel: MealDetailModel?) {
        self.durationSelectionViewModel.kitchenModel = kitchenModel
        self.durationSelectionViewModel.mealDetailModel = mealDetailModel
    }
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                CloudLabel(text: "Select Duration", font: .title, fontWeight: .bold, textAlignment: .leading)
                HStack {
                    getDatePickerView(date: $durationSelectionViewModel.startDate)
                    getDatePickerView(date: $durationSelectionViewModel.endDate)
                }
                CloudLabel(text: "Select Slot", font: .title, fontWeight: .bold, textAlignment: .leading)
            }
            .padding()
            getSlotsList()
            Spacer()
            getBottomButton()
                .padding()
        }
        .navigationDestination(isPresented: $showOrderView, destination: { OrderConfirmationView(mealDetailModel: self.durationSelectionViewModel.mealDetailModel) })
        .navigationBarBackButtonHidden()
        .toolbar {
            getToolbarView()
        }
    }
    @ToolbarContentBuilder
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: Constants.chevron_left)
            })
            .tint(.black)
        }
    }
    @ViewBuilder
    private func getDatePickerView(date: Binding<Date>) -> some View {
        HStack {
//            CloudLabel(text: "30 Mar 24")
            DatePicker("", selection: date, displayedComponents: [.date])
                .tint(.black)
                .blendMode(.colorBurn)
                .labelsHidden()
            Image(systemName: "calendar")
        }
        .padding()
        .addBorder(cornerRadius: 5)
    }
    @ViewBuilder
    private func getSlotsList() -> some View {
        List(durationSelectionViewModel.slotModels, id: \.slotNo) { slot in
            getSlotRow(slot: slot)
        }
        .listStyle(.inset)
    }
    @ViewBuilder
    private func getSlotRow(slot: SlotModel) -> some View {
        HStack {
            CloudLabel(text: "Slot-\(slot.slotNo)")
            Spacer(minLength: 30)
            HStack {
                CloudLabel(text: "\(slot.startTime) - \(slot.endTime)")
                Spacer()
                getAddButton(isAdded: slot.isSelected)
                    .onTapGesture {
                    durationSelectionViewModel.selectSlot(slot)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .addBorder(cornerRadius: 5)
        }
        .listRowSeparator(.hidden)
    }
    @ViewBuilder
    private func getBottomButton() -> some View {
        CloudButton(title: "PLACE ORDER") {
            self.showOrderView = true
        }
    }
    func getAddButton(isAdded: Bool) -> some View {
        var textColour: Color
        var background: Color
        if isAdded {
            textColour = .white
            background = .yellow
        } else {
            textColour = .yellow
            background = .white
        }
        return CloudLabel(text: "Select" , textColor: textColour)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .addBorder(cornerRadius: 5)
    }
}

//#Preview {
//    DurationSelectionView()
//}
