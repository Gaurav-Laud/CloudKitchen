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
    init(mealDetailModel: MealDetailModel?) {
        self.planSelectionViewModel.mealDetailModel = mealDetailModel
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CloudLabel(text: "Select your Plan", font: .title, fontWeight: .bold, textAlignment: .leading)
            getWeeklyView()
            getMonthlyView()
            Spacer()
            getBottomButton()
        }
        .padding()
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
    private func getWeeklyView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                CloudLabel(text: "Weekly Subscription", font: .title3)
                CloudLabel(text: "(5 Meals)")
                CloudLabel(text: "\(Constants.rupee_symbol) \(planSelectionViewModel.mealDetailModel?.weeklySubscriptionCost ?? 0)/Meal", font: .title2, fontWeight: .bold)
            }
            Spacer()
            getAddButton(isAdded: true)
        }
        .padding()
        .roundCorners(16)
        .addBorder()
    }
    @ViewBuilder
    private func getMonthlyView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                CloudLabel(text: "Monthly Subscription", font: .title3)
                CloudLabel(text: "(25 Meals)")
                CloudLabel(text: "\(Constants.rupee_symbol) \(planSelectionViewModel.mealDetailModel?.monthlySubscriptionCost ?? 0)/Meal", font: .title2, fontWeight: .bold)
            }
            Spacer()
            getAddButton(isAdded: false)
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
        CloudButton(title: "SELECT MENU")
    }
}
//
//#Preview {
//    PlanSelectionView()
//}
