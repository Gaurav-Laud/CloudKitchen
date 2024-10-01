//
//  OrderConfirmationView.swift
//  CloudKitchen
//
//  Created by E5000745 on 22/08/24.
//

import SwiftUI

struct OrderConfirmationView: View {
    @Environment(\.dismiss) private var dismiss
    @State var orderConfirmationViewModel = OrderConfirmationViewModel()
    @State var presentDurationView = false
    @State var presentPlanView = false
    init(kitchenModel: KitchenModel?, mealDetailModel: MealDetailModel?) {
        self.orderConfirmationViewModel.kitchenModel = kitchenModel
        self.orderConfirmationViewModel.mealDetailModel = mealDetailModel
    }
    var body: some View {
        VStack(spacing: 15) {
            self.getAddressView()
            self.getSavingView()
            self.getMealView()
            self.getSubscriptionDetailsView()
            self.getCostView()
            self.getOrderingView()
            Spacer()
            self.getBottomButton()
        }
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
    private func getAddressView() -> some View {
        HStack(alignment: .top) {
            Image("CustomCheckmark", bundle: Bundle.main)
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                CloudLabel(text: "Deliver at Home")
                CloudLabel(text: CloudKitchenUtility.shared.selectedAddress?.addressLine1 ?? "", font: .caption, textColor: .gray)
            }
            Spacer()
            CloudLabel(text: "Change", textColor: .red)
        }
        .padding()
        .background(.green.opacity(0.2))
        .roundCorners()
    }
    @ViewBuilder
    private func getSavingView() -> some View {
        HStack {
            CloudLabel(text: "Your Total Savings", textColor: .blue)
            Spacer()
            CloudLabel(text: "₹ 325.00", textColor: .blue)
        }
        .padding(.horizontal)
        .padding(.vertical, 6.0)
        .addBorder(cornerRadius: 11.0, borderColor: .blue)
    }
    @ViewBuilder
    private func getMealView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(Constants.veg_symbol, bundle: Bundle.main)
                        .resizable()
                        .frame(width: 17, height: 17)
                    CloudLabel(text: self.orderConfirmationViewModel.kitchenModel?.name ?? "", font: .title2, fontWeight: .bold)
                }
                CloudLabel(text: self.orderConfirmationViewModel.mealDetailModel?.description ?? "", font: .caption, textColor: .gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                self.getSubscriptionTypeView()
                CloudLabel(text: "\(Constants.rupee_symbol) \(self.orderConfirmationViewModel.getSubscriptionCost()) (\(self.orderConfirmationViewModel.getMealCount()) Meals)", font: .caption, textColor: .gray)
            }
        }
    }
    @ViewBuilder
    private func getSubscriptionTypeView() -> some View {
        CloudLabel(text: self.orderConfirmationViewModel.mealDetailModel?.selectedSubscriptionType.rawValue.uppercased() ?? "" , textColor: .red)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .addBorder(cornerRadius: 5, borderColor: .red)
    }
    @ViewBuilder
    private func getSubscriptionDetailsView() -> some View {
        VStack {
            HStack {
                CloudLabel(text: "SUBSCRIPTION", font: .title3, textColor: .gray, fontWeight: .bold)
                Spacer()
                CloudLabel(text: "Change", textColor: .red)
                    .onTapGesture {
                        presentDurationView = true
                    }
            }
            HStack {
                CloudLabel(text: "Plan duration", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "\(self.orderConfirmationViewModel.mealDetailModel?.startDate ?? "") - \(self.orderConfirmationViewModel.mealDetailModel?.endDate ?? "")")
            }
            HStack {
                CloudLabel(text: "Delivery Slot", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "\(self.orderConfirmationViewModel.mealDetailModel?.slot?.startTime ?? "") - \(self.orderConfirmationViewModel.mealDetailModel?.slot?.endTime ?? "")")
            }
        }
    }
    @ViewBuilder
    private func getCostView() -> some View {
        VStack {
            HStack {
                CloudLabel(text: "\(self.orderConfirmationViewModel.mealDetailModel?.selectedSubscriptionType.rawValue.capitalized ?? "") Subscription", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "\(Constants.rupee_symbol) \(self.orderConfirmationViewModel.getSubscriptionCost())", textColor: .gray)
            }
            HStack {
                CloudLabel(text: "Delivery Charges", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "\(Constants.rupee_symbol) \(self.orderConfirmationViewModel.getSubscriptionCost())", textColor: .gray)
            }
            HStack {
                CloudLabel(text: "Grand Total", font: .title2, fontWeight: .bold)
                Spacer()
                CloudLabel(text: "\(Constants.rupee_symbol) \(self.orderConfirmationViewModel.getTotalCost())")
            }
        }
    }
    @ViewBuilder
    private func getOrderingView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                CloudLabel(text: "ORDERING", font: .title3, textColor: .gray, fontWeight: .bold)
                CloudLabel(text: "Raja, 9848120717", font: .headline, textColor: .gray)
            }
            Spacer()
            CloudLabel(text: "Change", textColor: .red)
        }
    }
    @ViewBuilder
    private func getBottomButton() -> some View {
        CloudButton(title: "Pay Now") {
//            let str = """
//{"amount":3096,"amount_due":3096,"amount_paid":0,"attempts":0,"created_at":1724520447,"currency":"INR","entity":"order","id":"order_OooolyodXDLNZR","notes":{"key1":"value3","key2":"value2"},"offer_id":null,"receipt":"receipt_66c503aac731092cba80cc7a","status":"created"}
//"""
//            RazorPayUtility.shared.startPayment(for: str, amount: 1000)
        }
    }
}

//#Preview {
//    OrderConfirmationView()
//}
