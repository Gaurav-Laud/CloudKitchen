//
//  SubscriptionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import SwiftUI

struct SubscriptionView: View {
    var showManageButton: Bool = false
    init(showManageButton: Bool = false) {
        self.showManageButton = showManageButton
    }
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://res.cloudinary.com/mealboxhyd/image/upload/v1722669849/mealbox/meals/Veg%20and%20NonvVeg%20Combo%20Thali/616_ma7ruo.jpg"), content: { image in
                image.resizable()
            }, placeholder: {
                ProgressView()
            })
            .frame(height: 180)
            self.getSubscriptionInfoView()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 5)
    }
    @ViewBuilder
    private func getSubscriptionInfoView() -> some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                VStack(alignment: .leading) {
                    CloudLabel(text: "South Indian", font: .title, textColor: .yellow, fontWeight: .bold)
                    CloudLabel(text: "Idly · Dosa · Vada · Appam")
                }
                Spacer()
                self.getAmountView()
            }
            getReviewView()
            HStack {
                self.getAddressView()
                Spacer()
                self.getSubscriptionDateView()
            }
            if showManageButton {
                self.getBottomView()
            }
        }
        .padding()
    }
    @ViewBuilder
    private func getAddressView() -> some View {
        CloudLabel(text: /*UserDefaultsUtility.getUser()?.addresses.first?.addressLine1 ??*/ "8358 Liaison De la Passerelle, 92235 Tremblay-en-France", font: .footnote, textColor: .gray)
    }
    @ViewBuilder
    private func getReviewView() -> some View {
        HStack {
            self.getRatingStars()
            CloudLabel(text: "53 \(Constants.reviews)")
        }
    }
    @ViewBuilder
    private func getRatingStars() -> some View {
        let totalStars: Int = 5
        let filledStars: Int = 5 // Int(self.mealModel.ratingModel?.avgRating.rounded(.down) ?? 0)
        let halfStars: Int = 0 // (self.mealModel.ratingModel?.avgRating ?? 0 - Float(filledStars)) > 0 ? 1 : 0
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
    private func getSubscriptionDateView() -> some View {
        CloudLabel(text: "10 Apr-16 Apr", textAlignment: .trailing)
    }
    @ViewBuilder
    private func getAmountView() -> some View {
        VStack {
            CloudLabel(text: "Paid")
            CloudLabel(text: "420₹", font: .title2, fontWeight: .bold)
        }
    }
    @ViewBuilder
    private func getBottomView() -> some View {
        HStack {
            CloudButton(title: "Manage Subscription")
//            CloudLabel(text: "item not available", textColor: .yellow)
        }
    }
}

#Preview {
    SubscriptionView()
}
