//
//  AddAddressView.swift
//  CloudKitchen
//
//  Created by E5000745 on 19/07/24.
//

import SwiftUI

struct AddAddressView: View {
    @Environment(\.dismiss) private var dismiss
    @State var addAddressViewModel = AddAddressViewModel()
    @State var showErrorToast = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                getFieldView(title: "Full name", placeholder: "Lucy Lu", inputString: $addAddressViewModel.name)
                getFieldView(title: "Phone Number", placeholder: "Enter your phone number", inputString: $addAddressViewModel.phoneNumber)
                getFieldView(title: "Building Name / No.", placeholder: "Enter your address", inputString: $addAddressViewModel.buildingName)
                getFieldView(title: "Area", placeholder: "Enter your address", inputString: $addAddressViewModel.area)
                HStack(spacing: 25) {
                    getFieldView(title: "Zip Code", placeholder: "Zip Code", inputString: $addAddressViewModel.zipCode)
                    getFieldView(title: "City", placeholder: "City", inputString: $addAddressViewModel.city)
                }
                CloudButton(title: "ADD ADDRESS") {
                    guard addAddressViewModel.validateDetails() else {
                        showErrorToast = true
                        return
                    }
                    addAddressViewModel.saveAddress({ dismiss() })
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
            .toolbarRole(.navigationStack)
            .toolbar(content: { getToolBarView() })
            .tint(.black)
            .showToast(isPresenting: $showErrorToast, title: "Please fill all the fields")
        }
    }
    @ViewBuilder
    private func getFieldView(title: String, placeholder: String, inputString: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            CloudLabel(text: title, fontWeight: .bold)
            CloudTextField(placeholder: placeholder, inputString: inputString)
        }
    }
    @ToolbarContentBuilder
    private func getToolBarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            CloudLabel(text: "Enter Address Details", font: .title3, fontWeight: .bold)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: { dismiss() }, label: {
                Image(systemName: "xmark")
            })
        }
    }
}

#Preview {
    AddAddressView()
}
