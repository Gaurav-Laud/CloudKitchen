//
//  MealCardView.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/07/24.
//

import SwiftUI

struct MealCardView: View {
    var mealModel: MealModel
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: mealModel.images.first ?? ""), content: { image in
                image.resizable()
            }, placeholder: {
                ProgressView()
            })
            .frame(height: 180)
            self.getMealInfoView()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 5)
    }
    @ViewBuilder
    func getMealInfoView() -> some View {
        VStack() {
            self.getMealDetailsView()
                .padding()
            self.getSubscriptionsView()
        }
    }
    @ViewBuilder
    func getMealDetailsView() -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                CloudLabel(text: self.mealModel.name, font: .title,textColor: .yellow, fontWeight: .bold)
                Spacer()
                getAddButton()
            }
            CloudLabel(text: self.mealModel.description)
            getReviewView()
        }
    }
    
    func getAddButton() -> some View {
        var title: String
        var textColour: Color
        var background: Color
        if self.mealModel.isAdded {
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
    func getReviewView() -> some View {
        HStack {
            getRatingStars()
            CloudLabel(text: "\(self.mealModel.ratingModel?.noOfRatings ?? 0) \(Constants.reviews)")
        }
    }
    @ViewBuilder
    func getSubscriptionsView() -> some View {
        HStack(spacing: 2) {
            HStack {
                VStack(alignment: .leading) {
                    CloudLabel(text: Constants.weekly_subscription, font: .footnote)
                    CloudLabel(text: "\(self.mealModel.weeklySubscriptionCost)\(Constants.rupee_symbol)/\(Constants.meal)", font: .callout, fontWeight: .bold)
                }
                Spacer()
            }
            .padding(7)
            .background(.white)
            HStack {
            VStack(alignment: .leading) {
                CloudLabel(text: Constants.monthly_subscription, font: .footnote)
                CloudLabel(text: "\(self.mealModel.monthlySubscriptionCost)\(Constants.rupee_symbol)/\(Constants.meal)", font: .callout, fontWeight: .bold)
            }
                Spacer()
            }
            .padding(7)
            .background(.white)
        }
        .padding(.top, 2)
        .background(
            .gray.opacity(0.4)
        )
    }
    @ViewBuilder
    func getRatingStars() -> some View {
        let totalStars: Int = 5
        let filledStars: Int = Int(self.mealModel.ratingModel?.avgRating.rounded(.down) ?? 0)
        let halfStars: Int = (self.mealModel.ratingModel?.avgRating ?? 0 - Float(filledStars)) > 0 ? 1 : 0
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
}

//#Preview {
//    MealCardView()
//}
