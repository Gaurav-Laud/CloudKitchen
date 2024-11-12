//
//  DateSelectionView.swift
//  CloudKitchen
//
//  Created by E5000745 on 12/11/24.
//

import SwiftUI

protocol DateSelectionViewDelegate {
    func didSelectActionButton(source: String)
}
struct DateSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    var delegate: DateSelectionViewDelegate?
    let source: String
    @Binding var startDate: Date
    @Binding var endDate: Date
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    CloudLabel(text: "Start Date", font: .title2)
                    getDatePickerView(date: $startDate)
                }
                Spacer(minLength: 10)
                VStack(alignment: .leading) {
                    CloudLabel(text: "End Date", font: .title2)
                    getDatePickerView(date: $endDate)
                }
            }
            Spacer()
            CloudButton(title: "Confirm Changes", isTextCaps: true) {
                self.delegate?.didSelectActionButton(source: self.source)
                dismiss()
            }
        }
        .padding()
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
    private func getDatePickerView(date: Binding<Date>) -> some View {
        HStack {
            DatePicker("", selection: date, displayedComponents: [.date])
                .tint(.black)
                .blendMode(.colorBurn)
                .labelsHidden()
            Image(systemName: "calendar")
        }
        .padding()
        .addBorder(cornerRadius: 5)
    }
}

//#Preview {
//    DateSelectionView(startDate: Date(), endDate: Date())
//}
