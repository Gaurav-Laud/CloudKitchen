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
    init(mealDetailModel: MealDetailModel?) {
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
                CloudLabel(text: "8358 Liaison De la Passerelle, 92235 Tremblay-en-France", font: .caption, textColor: .gray)
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
                    CloudLabel(text: "House of Meals", font: .title2, fontWeight: .bold)
                }
                CloudLabel(text: "Biryani · North Indian · Salads · Cakes · Meals · Shakes · Rolls · Pizza", font: .caption, textColor: .gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                self.getSubscriptionTypeView()
                CloudLabel(text: "₹ 420.00 (6 Meals)", font: .caption, textColor: .gray)
            }
        }
    }
    @ViewBuilder
    private func getSubscriptionTypeView() -> some View {
        CloudLabel(text: "title" , textColor: .red)
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
            }
            HStack {
                CloudLabel(text: "Plan duration", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "10 Apr-16 Apr")
            }
            HStack {
                CloudLabel(text: "Delivery Slot", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "12:30 P.M - 01:00 P.M")
            }
        }
    }
    @ViewBuilder
    private func getCostView() -> some View {
        VStack {
            HStack {
                CloudLabel(text: "Monthly Subscription", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "₹420", textColor: .gray)
            }
            HStack {
                CloudLabel(text: "Delivery Charges", font: .title3, textColor: .gray)
                Spacer()
                CloudLabel(text: "₹0", textColor: .gray)
            }
            HStack {
                CloudLabel(text: "Grand Total", font: .title2, fontWeight: .bold)
                Spacer()
                CloudLabel(text: "₹420")
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
}

//#Preview {
//    OrderConfirmationView()
//}
