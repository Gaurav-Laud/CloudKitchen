//
//  PlanSelectionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 31/07/24.
//

import SwiftUI

struct PlanSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var planSelectionViewModel = PlanSelectionViewModel()
    @State var presentDurationView = false
    init(kitchenModel: KitchenModel?, mealDetailModel: MealDetailModel?) {
        self.planSelectionViewModel.kitchenModel = kitchenModel
        self.planSelectionViewModel.mealDetailModel = mealDetailModel
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CloudLabel(text: "Select your Plan", font: .title, fontWeight: .bold, textAlignment: .leading)
            ForEach(planSelectionViewModel.kitchenModel?.kitchenDetailsModel?.availablePlans ?? [], id: \._id) { availablePlan in
                self.getPlanView(for: availablePlan)
            }
            Spacer()
            getBottomButton()
        }
        .navigationDestination(isPresented: $presentDurationView, destination: { DurationSelectionView(kitchenModel: self.planSelectionViewModel.kitchenModel, mealDetailModel: self.planSelectionViewModel.mealDetailModel) })
        .padding()
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
    private func getPlanView(for availableplanModel: AvailablePlanModel) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                CloudLabel(text: availableplanModel.name, font: .title3)
                CloudLabel(text: "(\(availableplanModel.noOfMeals) Meals)")
                CloudLabel(text: "\(Constants.rupee_symbol) \(planSelectionViewModel.getSubscriptionCost(for: availableplanModel.type) ?? 0)/Meal", font: .title2, fontWeight: .bold)
            }
            Spacer()
            getAddButton(isAdded: availableplanModel.isSelected)
                .onTapGesture {
                    planSelectionViewModel.selectSubscription(availableplanModel.type)
                }
        }
        .padding()
        .roundCorners(16)
        .addBorder()
    }
    func getAddButton(isAdded: Bool) -> some View {
        var title: String
        var textColour: Color
        var background: Color
        if isAdded {
            title = Constants.added
            textColour = .white
            background = .yellow
        } else {
            title = Constants.add
            textColour = .yellow
            background = .white
        }
        return CloudLabel(text: title , textColor: textColour)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .addBorder(cornerRadius: 5)
    }
    @ViewBuilder
    private func getBottomButton() -> some View {
        CloudButton(title: "SELECT MENU") {
            self.presentDurationView = true
        }
    }
}
//
//#Preview {
//    PlanSelectionView()
//}
