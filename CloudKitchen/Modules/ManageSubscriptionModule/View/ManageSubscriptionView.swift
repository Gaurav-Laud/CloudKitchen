//
//  ManageSubscriptionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import SwiftUI

struct ManageSubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var manageSubscriptionViewModel: ManageSubscriptionViewModel
    init(subscriptionModel: SubscriptionModel?) {
        self.manageSubscriptionViewModel = ManageSubscriptionViewModel(subscriptionModel: subscriptionModel)
    }
    var body: some View {
        if let subscriptionModel = manageSubscriptionViewModel.subscriptionModel {
            ScrollView {
                VStack(alignment: .leading) {
                    SubscriptionView(subscription: subscriptionModel)
                    self.getPickerView()
                    self.getMealView(for: self.manageSubscriptionViewModel.getSelectedMenuItem())
//                    self.getActionView()
                    CloudLabel(text: "Subscription", font: .title2, fontWeight: .bold, textAlignment: .leading)
                    self.getDateView()
                    self.getSeperator()
                    self.getAddressView()
                    self.getDeliveryTimeView()
                }
            }
            .scrollIndicators(.never)
            .padding()
            .navigationBarBackButtonHidden()
            .toolbar {
                self.getToolbarView()
            }
        } else {
            EmptyView()
                .toolbar {
                    self.getToolbarView()
                }
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
    private func getMealView(for menuItemModel: MenuItemModel) -> some View {
        HStack(spacing: 15) {
            self.getMealImageView(menuItemModel: menuItemModel)
            VStack(alignment: .leading) {
                ForEach(menuItemModel.items, id: \.self) { item in
                    CloudLabel(text: item, font: .title3, fontWeight: .bold)
                }
            }
        }
    }
    @ViewBuilder
    private func getMealImageView(menuItemModel: MenuItemModel) -> some View {
        AsyncImage(url: URL(string: menuItemModel.image), content: { image in
            image.resizable()
        }, placeholder: {
            ProgressView()
        })
        .frame(width: 125, height: 100)
        .roundCorners(6)
    }
    @ViewBuilder
    private func getAddressView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                CloudLabel(text: "Delivery Address", textAlignment: .leading)
                CloudLabel(text: "\(self.manageSubscriptionViewModel.subscriptionModel?.delieveryAddress?.addressLine1 ?? "")", textAlignment: .leading)
                CloudLabel(text: "\(self.manageSubscriptionViewModel.subscriptionModel?.delieveryAddress?.addressLine2 ?? "")", textAlignment: .leading)
            }
            Spacer()
//            CloudLabel(text: "Change", textColor: .yellow, fontWeight: .bold)
        }
    }
    @ViewBuilder
    private func getActionView() -> some View {
        HStack {
            self.getButton(title: "Swap", textColor: .white, backgroundColor: .yellow)
            Spacer()
            self.getButton(title: "Skip", textColor: .yellow, backgroundColor: .white)
            Spacer()
            self.getButton(title: "Cancel", textColor: .yellow, backgroundColor: .white)
        }
        .padding()
    }
    @ViewBuilder
    private func getButton(title: String, textColor: Color, backgroundColor: Color, action: @escaping (() -> Void) = { }) -> some View {
        CloudLabel(text: title , textColor: textColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .addBorder(cornerRadius: 5)
            .onTapGesture {
                action()
            }
    }
    @ViewBuilder
    private func getDateView() -> some View {
        HStack {
            CloudLabel(text: "\(self.manageSubscriptionViewModel.subscriptionModel?.startDate ?? "") - \(self.manageSubscriptionViewModel.subscriptionModel?.endDate ?? "")")
            Spacer()
            getButton(title: "Donate", textColor: .white, backgroundColor: .yellow) {
                self.manageSubscriptionViewModel.donateSubscription()
            }
            getButton(title: "Pause", textColor: .white, backgroundColor: .yellow) {
                self.manageSubscriptionViewModel.pauseSubscription()
            }
        }
    }
    @ViewBuilder
    private func getSeperator() -> some View {
        Rectangle()
            .foregroundStyle(.gray)
            .frame(height: 1)
    }
    @ViewBuilder
    private func getPickerView() -> some View {
        Picker("", selection: $manageSubscriptionViewModel.selectedWeek) {
            ForEach(self.manageSubscriptionViewModel.weeks, id: \.self) { weekTitle in
                Text(weekTitle)
            }
        }
        .pickerStyle(.segmented)
        .padding(.vertical)
    }
    @ViewBuilder
    private func getDeliveryTimeView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                CloudLabel(text: "12:30 P.M - 01:00 P.M")
                CloudLabel(text: "Available at-least 1hr Prior to delivery")
            }
            Spacer()
            CloudLabel(text: "Reschedule", textColor: .gray)
        }
    }
    private func getWeekTitles(for dateString: String) -> String {
        dateString.convertFormatOfDate(from: "yyyy-MM-dd", to: "dd MMM") ?? dateString
    }
}
//
//#Preview {
//    ManageSubscriptionView()
//}
