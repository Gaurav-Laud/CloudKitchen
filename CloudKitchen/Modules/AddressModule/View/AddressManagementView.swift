//
//  AddressManagementView.swift
//  CloudKitchen
//
//  Created by E5000745 on 17/07/24.
//

import SwiftUI

struct AddressManagementView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var addressManagementViewModel = AddressManagementViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            CloudTextField(placeholder: "Search area, town, city.....", inputString: $addressManagementViewModel.searchString, image: Constants.magnifying_glass)
            getMyLocationView()
            CloudLabel(text: Constants.add_select_location, font: .title2, fontWeight: .bold, textAlignment: .leading)
            getAddressGridView()
            Spacer()
            getBottomButton()
        }
        .padding()
        .toolbar { getToolbarView() }
        .navigationBarBackButtonHidden()
    }
    @ViewBuilder
    private func getMyLocationView() -> some View {
        Button(action: { self.getLocation() }) {
            HStack {
                Image(systemName: "dot.scope")
                    .font(.largeTitle)
                    .foregroundStyle(.yellow)
                CloudLabel(text: "Use my location", font: .title3, fontWeight: .bold, textAlignment: .leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
        }
        .tint(.black)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(.white)
        .roundCorners()
        .shadow(radius: 5)
    }
    @ViewBuilder
    private func getAddressGridView() -> some View {
        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 8) {
            ForEach(addressManagementViewModel.addresses) {
                getAddressView(address: $0)
            }
        }
    }
    @ViewBuilder
    private func getAddressView(address: LocationModel) -> some View {
        VStack(alignment: .leading) {
            CloudLabel(text: address.name ?? "", font: .title3, textAlignment: .leading)
            CloudLabel(text: "\(address.houseNo), \(address.addressLine1)", font: .footnote, textAlignment: .leading)
        }
        .background(.white)
        .roundCorners()
        .shadow(radius: 5)
    }
    @ViewBuilder
    private func getBottomButton() -> some View {
        CloudButton(title: "USE THIS ADDRESS")
    }
    @ToolbarContentBuilder
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: Constants.xmark)
            })
            .tint(.black)
        }
        ToolbarItem(placement: .topBarLeading) {
            CloudLabel(text: Constants.add_select_location, fontWeight: .bold, textAlignment: .leading)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: { dismiss() }, label: {
                Image(systemName: "plus.circle.fill")
                    .tint(.yellow)
            })
        }
    }
    private func getLocation() {
        addressManagementViewModel.getLocation { _ in dismiss() }
    }
}

#Preview {
    AddressManagementView()
}
