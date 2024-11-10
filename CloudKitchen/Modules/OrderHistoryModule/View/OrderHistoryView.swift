//
//  OrderHistoryView.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import SwiftUI

struct OrderHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var orderHistoryViewModel = OrderHistoryViewModel()
    var body: some View {
        List(orderHistoryViewModel.orders, id: \._id) { order in
            OrderView(orderModel: order)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            self.getToolbarView()
        }
        .onAppear(perform: { orderHistoryViewModel.fetchOrders() })
    }
    @ToolbarContentBuilder
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: Constants.chevron_left)
            })
            .tint(.black)
        }
        ToolbarItem(placement: .topBarLeading) {
            CloudLabel(text: "Order History", font: .title2)
        }
    }
}

struct OrderView: View {
    @State var orderModel: OrderModel
    init(orderModel: OrderModel) {
        self.orderModel = orderModel
    }
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: self.orderModel.meal?.bannerImage ?? ""), content: { image in
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
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    CloudLabel(text: orderModel.meal?.name ?? "", font: .title, textColor: .yellow, fontWeight: .bold)
                    CloudLabel(text: orderModel.meal?.description ?? "")
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
            self.getBottomView()
        }
        .padding()
    }
    @ViewBuilder
    private func getAddressView() -> some View {
        CloudLabel(text: UserDefaultsUtility.getUser()?.addresses.first?.addressLine1 ?? "", font: .footnote, textColor: .gray)
    }
    @ViewBuilder
    private func getReviewView() -> some View {
        HStack {
            self.getRatingStars()
            CloudLabel(text: "\(orderModel.meal?.ratingModel?.noOfRatings ?? 0) \(Constants.reviews)")
        }
    }
    @ViewBuilder
    private func getRatingStars() -> some View {
        let totalStars: Int = 5
        let filledStars: Int = Int(self.orderModel.meal?.ratingModel?.avgRating.rounded(.down) ?? 0)
        let halfStars: Int = (self.orderModel.meal?.ratingModel?.avgRating ?? 0 - Float(filledStars)) > 0 ? 1 : 0
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
        CloudLabel(text: self.orderModel.deliveryTimeSlot, textAlignment: .trailing)
    }
    @ViewBuilder
    private func getAmountView() -> some View {
        VStack {
            CloudLabel(text: "Paid")
            CloudLabel(text: "\(self.orderModel.grandTotal) \(Constants.rupee_symbol)", font: .title2, fontWeight: .bold)
        }
    }
    @ViewBuilder
    private func getBottomView() -> some View {
        VStack(alignment: .trailing) {
            CloudLabel(text: "Order Delivered On", textColor: .gray)
        }
    }
}

#Preview {
    OrderHistoryView()
}
