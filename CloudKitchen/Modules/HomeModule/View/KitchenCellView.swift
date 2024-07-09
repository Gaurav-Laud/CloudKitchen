//
//  KitchenCellView.swift
//  CloudKitchen
//
//  Created by E5000745 on 07/07/24.
//

import SwiftUI

struct KitchenCellView: View {
    var kitchenModel: KitchenModel
    var body: some View {
            VStack {
                AsyncImage(url: URL(string: "\(kitchenModel.bannerImage)"), content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                })
                    .frame(height: 180)
                getBottomView()
                    .padding()
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 5)
//            .padding()
    }
    @ViewBuilder
    private func getBottomView() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                CloudLabel(text: self.kitchenModel.name, font: .title,textColor: .yellow, fontWeight: .bold)
                Text(self.kitchenModel.description)
            }
            Spacer()
            VStack(alignment: .trailing) {
                getRatingView(rating: kitchenModel.avgRating)
                CloudLabel(text: "\(Constants.starts_from) \(kitchenModel.startingPrice)",textColor: .secondary)
                CloudLabel(text: "Delivery in 21 min")
            }
        }
    }
    @ViewBuilder
    private func getRatingView(rating: Float) -> some View {
        HStack {
            Text(String(format: "%0.1f", rating))
                .foregroundStyle(.white)
            Image(systemName: Constants.star_fill)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 5)
        .background(.green)
        .clipShape(Capsule())
    }
}

//#Preview {
//    KitchenCellView()
//}
