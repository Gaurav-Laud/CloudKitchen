//
//  ProfileView.swift
//  CloudKitchen
//
//  Created by E5000745 on 03/10/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var presentSettingView: Bool = false
    @State private var orderHistoryView: Bool = false
    let profileViewModel = ProfileViewModel()
    var body: some View {
        Text(self.profileViewModel.getUserName())
        VStack(spacing: 23) {
            ForEach(self.profileViewModel.getOptions(), id: \.rawValue, content: { option in
                self.getOptionView(for: option)
                    .onTapGesture {
                        self.optionSelected(option: option)
                    }
            })
        }
        .padding()
        .toolbar { getToolbarView() }
        .navigationBarBackButtonHidden()
    }
    @ViewBuilder
    private func getOptionView(for option: ProfileOption) -> some View {
        HStack {
            self.getOptionImageView(for: option)
            CloudLabel(text: option.getTitle(), font: .title2, fontWeight: .bold)
            Spacer()
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 25, height: 20)
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 20)
        .background(.white)
        .roundCorners()
        .shadow(radius: 10)
    }
    private func getToolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Label("", systemImage: Constants.chevron_left)
            })
            .tint(.black)
        }
    }
    @ViewBuilder
    private func getOptionImageView(for option: ProfileOption) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(Color(hexString: option.getBackGroundColor()))
                .frame(width: 50, height: 50)
            Image(systemName: option.getImage())
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 25, height: 25)
        }

    }
    func optionSelected(option: ProfileOption) {
        switch option {
        case .profileSetting: self.presentSettingView = true
        case .orderHistory: self.orderHistoryView = true
        default: break
        }
    }
}

#Preview {
    ProfileView()
}
