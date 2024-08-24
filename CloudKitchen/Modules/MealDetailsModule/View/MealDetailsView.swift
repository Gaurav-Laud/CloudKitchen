//
//  MealDetailsView.swift
//  CloudKitchen
//
//  Created by E5000745 on 29/07/24.
//

import SwiftUI

struct MealDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var mealDetailsViewModel = MealDetailsViewModel()
    @State private var presentPlanSelectionView = false
    init(mealId: String, kitchenModel: KitchenModel?) {
        mealDetailsViewModel.mealId = mealId
        mealDetailsViewModel.kitchenModel = kitchenModel
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CloudLabel(text: mealDetailsViewModel.mealDetailModel?.name ?? "", font: .title, fontWeight: .bold)
            getReviewView(for: mealDetailsViewModel.mealDetailModel?.avgRating ?? 0, reviews: mealDetailsViewModel.mealDetailModel?.noOfRatings ?? 0)
            CloudLabel(text: mealDetailsViewModel.mealDetailModel?.description ?? "", font: .caption)
            CloudLabel(text: "Overview", font: .title2, fontWeight: .bold)
            getMenuView()
           getBottomButton()
        }
        .navigationDestination(isPresented: $presentPlanSelectionView, destination: { PlanSelectionView(kitchenModel: self.mealDetailsViewModel.kitchenModel, mealDetailModel: mealDetailsViewModel.mealDetailModel) })
        .padding()
        .toolbar { getToolbarView() }
        .navigationBarBackButtonHidden()
        .onAppear{ mealDetailsViewModel.fetchMealDetails(for: mealDetailsViewModel.mealId) }
    }
    @ViewBuilder
    func getReviewView(for rating: Float, reviews: Int) -> some View {
        HStack {
            getRatingStars(for: rating)
            CloudLabel(text: "\(reviews) \(Constants.reviews)")
        }
    }
    @ViewBuilder
    func getRatingStars(for rating: Float) -> some View {
        let totalStars: Int = 5
        let filledStars: Int = Int(rating.rounded(.down))
        let halfStars: Int = (rating - Float(filledStars)) > 0 ? 1 : 0
        let emptyStars: Int = totalStars - filledStars - halfStars
        HStack {
            ForEach(0..<filledStars, id: \.self) { _ in
                Image(systemName: Constants.star_fill)
                    .foregroundStyle(.yellow)
            }
            ForEach(0..<halfStars, id: \.self) { _ in
                Image(systemName: Constants.star_leadinghalf_filled)
                    .foregroundStyle(.yellow)
            }
            ForEach(0..<emptyStars, id: \.self) { _ in
                Image(systemName: Constants.star)
                    .foregroundStyle(.gray.opacity(0.4))
            }
        }
    }
    @ViewBuilder
    func getMenuView() -> some View {
        Picker("", selection: $mealDetailsViewModel.selectedWeek) {
            ForEach(mealDetailsViewModel.weeks, id: \.self) { weekTitle in
                Text(weekTitle)
            }
        }
        .pickerStyle(.segmented)
        List(mealDetailsViewModel.mealDetailModel?.monthlyMenu[mealDetailsViewModel.selectedWeek] ?? [], id: \.id) { menuItem in
            MenuItemView(menuItem: menuItem)
                .listRowSeparator(.hidden)
        }
        .listRowBackground(Color.clear)
        .listStyle(.inset)
        .scrollIndicators(.never)
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
    private func getBottomButton() -> some View {
        CloudButton(title: "Select Plan", action: { presentPlanSelectionView = true })
    }
}

//#Preview {
//    MealDetailsView()
//}
