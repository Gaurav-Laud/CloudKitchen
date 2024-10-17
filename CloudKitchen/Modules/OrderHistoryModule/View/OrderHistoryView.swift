//
//  OrderHistoryView.swift
//  CloudKitchen
//
//  Created by E5000745 on 14/10/24.
//

import SwiftUI

struct OrderHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State var orderHistoryViewModel = OrderHistoryViewModel()
    var body: some View {
        List(orderHistoryViewModel.orders, id: \._id) { order in
            Text("\(order._id)***")
        }
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
}

#Preview {
    OrderHistoryView()
}
