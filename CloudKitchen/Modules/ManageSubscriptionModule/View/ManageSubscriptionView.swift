//
//  ManageSubscriptionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/10/24.
//

import SwiftUI

struct ManageSubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var manageSubscriptionViewModel = ManageSubscriptionViewModel()
    @State var ind: Int = 0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                SubscriptionView()
                self.getPickerView()
                self.getMealView()
                self.getActionView()
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
    private func getMealView() -> some View {
        HStack(spacing: 15) {
            self.getMealImageView()
            VStack(alignment: .leading) {
                CloudLabel(text: "Biryani", font: .title3, fontWeight: .bold)
                CloudLabel(text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", font: .caption)
            }
        }
    }
    @ViewBuilder
    private func getMealImageView() -> some View {
        AsyncImage(url: URL(string: "https://res.cloudinary.com/mealboxhyd/image/upload/v1722669849/mealbox/meals/Veg%20and%20NonvVeg%20Combo%20Thali/616_ma7ruo.jpg"), content: { image in
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
                CloudLabel(text: "8358 Liaison De la Passerelle, 92235 Tremblay-en-France", textAlignment: .leading)
            }
            Spacer()
            CloudLabel(text: "Change", textColor: .yellow, fontWeight: .bold)
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
    private func getButton(title: String, textColor: Color, backgroundColor: Color) -> some View {
        CloudLabel(text: title , textColor: textColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .addBorder(cornerRadius: 5)
    }
    @ViewBuilder
    private func getDateView() -> some View {
        HStack {
            CloudLabel(text: "10 Apr-16 Apr")
            Spacer()
            getButton(title: "Pause", textColor: .white, backgroundColor: .yellow)
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
        Picker("", selection: $ind) {
            ForEach(["1","2"], id: \.self) { weekTitle in
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
}

#Preview {
    ManageSubscriptionView()
}
